<?php

namespace App\Http\Controllers\Front;

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\View;
use Illuminate\Pagination\Paginator;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Mail;
use Illuminate\Http\Request;
use App\Category;
use App\Product;
use App\ProductsAttribute;
use Session;
use App\Cart;
use Auth;
use App\Coupon;
use App\User;
use App\DeliveryAddress;
use App\Country;
use App\Order;
use App\OrdersProduct;
use DB;
use App\Sms;

class ProductsController extends Controller
{
    public function listing(Request $request){
        Paginator::useBootstrap();
        if($request->ajax()){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/
            $url = $data['url'];
            $categoryCount = Category::where(['url'=>$url,'status'=>1])->count();
            if($categoryCount>0){
                $categoryDetails = Category::catDetails($url);
                $categoryProducts = Product::with('brand')->whereIn('category_id',$categoryDetails['catIds'])->where('status',1);

                // If Fabric filter is selected
                if(isset($data['fabric']) && !empty($data['fabric'])){
                    $categoryProducts->whereIn('products.fabric',$data['fabric']);
                }

                // If Sleeve filter is selected
                if(isset($data['sleeve']) && !empty($data['sleeve'])){
                    $categoryProducts->whereIn('products.sleeve',$data['sleeve']);
                }

                // If Pattern filter is selected
                if(isset($data['pattern']) && !empty($data['pattern'])){
                    $categoryProducts->whereIn('products.pattern',$data['pattern']);
                }

                // If Fit filter is selected
                if(isset($data['fit']) && !empty($data['fit'])){
                    $categoryProducts->whereIn('products.fit',$data['fit']);
                }

                // If Occasion filter is selected
                if(isset($data['occasion']) && !empty($data['occasion'])){
                    $categoryProducts->whereIn('products.occasion',$data['occasion']);
                }

                // If Sort option is selected
                if(isset($data['sort']) && !empty($data['sort'])){
                    if($data['sort']=="product_latest"){
                        $categoryProducts->orderBy('id','Desc');
                    }else if($data['sort']=="product_name_a_z"){
                        $categoryProducts->orderBy('product_name','Asc');
                    }else if($data['sort']=="product_name_z_a"){
                        $categoryProducts->orderBy('product_name','Desc');
                    }else if($data['sort']=="price_lowest"){
                        $categoryProducts->orderBy('product_price','Asc');
                    }else if($data['sort']=="price_highest"){
                        $categoryProducts->orderBy('product_price','Desc');
                    }
                }else{
                    $categoryProducts->orderBy('id','Desc');
                }

                $categoryProducts = $categoryProducts->paginate(30);
                /*echo "<pre>"; print_r($categoryDetails); die;*/
                return view('front.products.ajax_products_listing')->with(compact('categoryDetails','categoryProducts','url'));
            }else{
                abort(404);
            }  
        }else{
            $url = Route::getFacadeRoot()->current()->uri();
            $categoryCount = Category::where(['url'=>$url,'status'=>1])->count();
            if($categoryCount>0){
                $categoryDetails = Category::catDetails($url);
                $categoryProducts = Product::with('brand')->whereIn('category_id',$categoryDetails['catIds'])->where('status',1);
                $categoryProducts = $categoryProducts->paginate(30);
                /*echo "<pre>"; print_r($categoryDetails); die;*/

                // Product Filters
                $productFilters = Product::productFilters();
                $fabricArray = $productFilters['fabricArray'];
                $sleeveArray = $productFilters['sleeveArray'];
                $patternArray = $productFilters['patternArray'];
                $fitArray = $productFilters['fitArray'];
                $occasionArray = $productFilters['occasionArray'];

                $page_name = "listing";
                return view('front.products.listing')->with(compact('categoryDetails','categoryProducts','url','fabricArray','sleeveArray','patternArray','fitArray','occasionArray','page_name'));
            }else{
                abort(404);
            }    
        }    	
    }

    public function detail($id){
        $productDetails = Product::with(['category','brand','attributes'=>function($query){
            $query->where('status',1);
        },'images'])->find($id)->toArray();
        $total_stock = ProductsAttribute::where('product_id',$id)->sum('stock');
        $relatedProducts = Product::where('category_id',$productDetails['category']['id'])->where('id','!=',$id)->limit(3)->inRandomOrder()->get()->toArray();
        /*dd($relatedProducts); die;*/
        return view('front.products.detail')->with(compact('productDetails','total_stock','relatedProducts'));
    }

    public function getProductPrice(Request $request){
        if($request->ajax()){
            $data = $request->all();
            $getDiscountedAttrPrice = Product::getDiscountedAttrPrice($data['product_id'],$data['size']);
            return $getDiscountedAttrPrice;
        }
    }

    public function addtocart(Request $request){
        if($request->isMethod('post')){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/

            // Check Product Stock is available or not
            $getProductStock = ProductsAttribute::where(['product_id'=>$data['product_id'],'size'=>$data['size']])->first()->toArray();
            if($getProductStock['stock']<$data['quantity']){
                $message = "Required Quantity is not available!";
                session::flash('error_message',$message);
                return redirect()->back();
            }

            // Generate Session Id if not exists
            $session_id = Session::get('session_id');
            if(empty($session_id)){
                $session_id = Session::getId();
                Session::put('session_id',$session_id);
            }

            // Check Product if already exists in User Cart
            if(Auth::check()){
                // User is logged in
                $countProducts = Cart::where(['product_id'=>$data['product_id'],'size'=>$data['size'],'user_id'=>Auth::user()->id])->count();
            }else{
                // User is not logged in
                $countProducts = Cart::where(['product_id'=>$data['product_id'],'size'=>$data['size'],'session_id'=>Session::get('session_id')])->count();    
            }
            if($countProducts>0){
                $message = "Product already exists in Cart!";
                session::flash('error_message',$message);
                return redirect()->back();
            }

            if(Auth::check()){
                $user_id = Auth::user()->id;
            }else{
                $user_id = 0;
            }

            // Save Product in Cart
            $cart = new Cart;
            $cart->session_id = $session_id;
            $cart->user_id = $user_id;
            $cart->product_id = $data['product_id'];
            $cart->size = $data['size'];
            $cart->quantity = $data['quantity'];
            $cart->save();

            $message = "Product has been added in Cart!";
            session::flash('success_message',$message);
            return redirect('cart');

        }
    }

    public function cart(){
        $userCartItems = Cart::userCartItems();
        /*echo "<pre>"; print_r($userCartItems); die;*/
        return view('front.products.cart')->with(compact('userCartItems'));
    }

    public function updateCartItemQty(Request $request){
        if($request->ajax()){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/

            // Get Cart Details
            $cartDetails = Cart::find($data['cartid']);

            // Get Available Product Stock
            $availableStock = ProductsAttribute::select('stock')->where(['product_id'=>$cartDetails['product_id'],'size'=>$cartDetails['size']])->first()->toArray();

            // Check Stock is available or not
            if($data['qty']>$availableStock['stock']){
                $userCartItems = Cart::userCartItems();
                return response()->json([
                    'status'=>false,
                    'message'=>'Product Stock is not available',
                    'view'=>(String)View::make('front.products.cart_items')->with(compact('userCartItems'))
                ]);
            }

            // Check Size Available
            $availableSize = ProductsAttribute::where(['product_id'=>$cartDetails['product_id'],'size'=>$cartDetails['size'],'status'=>1])->count();
            if($availableSize==0){
                $userCartItems = Cart::userCartItems();
                return response()->json([
                    'status'=>false,
                    'message'=>'Product Size is not available',
                    'view'=>(String)View::make('front.products.cart_items')->with(compact('userCartItems'))
                ]);    
            }

            Cart::where('id',$data['cartid'])->update(['quantity'=>$data['qty']]);
            $userCartItems = Cart::userCartItems();
            $totalCartItems = totalCartItems();
            return response()->json([
                'status'=>true,
                'totalCartItems'=>$totalCartItems,
                'view'=>(String)View::make('front.products.cart_items')->with(compact('userCartItems'))
            ]);
        }
    }

    public function deleteCartItem(Request $request){
        if($request->ajax()){
            $data = $request->all();
            Cart::where('id',$data['cartid'])->delete();
            $userCartItems = Cart::userCartItems();
            $totalCartItems = totalCartItems();
            return response()->json([
                'totalCartItems'=>$totalCartItems,
                'view'=>(String)View::make('front.products.cart_items')->with(compact('userCartItems'))
            ]);
        }
    }

    public function applyCoupon(Request $request){
        if($request->ajax()){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/
            $userCartItems = Cart::userCartItems();
            $couponCount = Coupon::where('coupon_code',$data['code'])->count();
            if($couponCount==0){
                $userCartItems = Cart::userCartItems();
                $totalCartItems = totalCartItems();
                return response()->json([
                    'status'=>false,
                    'message'=>'This coupon is not valid!',
                    'totalCartItems'=>$totalCartItems,
                    'view'=>(String)View::make('front.products.cart_items')->with(compact('userCartItems'))
                ]);
            }else{
                // Check for other coupon conditions

                // Get Coupon Details
                $couponDetails = Coupon::where('coupon_code',$data['code'])->first();

                // Check if coupon is Inactive
                if($couponDetails->status==0){
                    $message = 'This coupon is not active!';
                }

                // Check if coupon is Expired
                $expiry_date = $couponDetails->expiry_date;
                $current_date = date('Y-m-d');
                if($expiry_date<$current_date){
                    $message = 'This coupon is expired!';
                }

                // Check if coupon is from selected categories
                // Get all selected categories from coupon
                $catArr = explode(",",$couponDetails->categories);

                // Get Cart Items
                $userCartItems = Cart::userCartItems();
                /*echo "<pre>"; print_r($userCartItems); die;*/

                // Check if coupon belongs to logged in user
                // Get all selected users of coupon
                if(!empty($couponDetails->users)){
                    $usersArr = explode(",", $couponDetails->users);
                    // Get User ID's of all selected users
                    foreach ($usersArr as $key => $user) {
                        $getUserID = User::select('id')->where('email',$user)->first()->toArray();
                        $userID[] = $getUserID['id'];
                    }    
                }
                

                 // Get Cart Total Amount
                 $total_amount = 0;
                 foreach ($userCartItems as $key => $item) {

                    if(!in_array($item['product']['category_id'], $catArr)){
                        $message = 'This coupon code is not for one of the selected products!';
                    }

                    if(!empty($couponDetails->users)){
                        if(!in_array($item['user_id'], $userID)){
                            $message = 'This coupon code is not for you!';   
                        }
                    }

                    $attrPrice = Product::getDiscountedAttrPrice($item['product_id'],$item['size']);
                    $total_amount = $total_amount + ($attrPrice['final_price']*$item['quantity']);

                 }

                if(isset($message)){
                    $userCartItems = Cart::userCartItems();
                    $totalCartItems = totalCartItems();
                    return response()->json([
                        'status'=>false,
                        'message'=>$message,
                        'totalCartItems'=>$totalCartItems,
                        'view'=>(String)View::make('front.products.cart_items')->with(compact('userCartItems'))
                    ]);    
                }else{
                    /*echo "Coupon can be successfully redeemed"; die;*/

                    // Check if amount type is Fixed or Percentage
                    if($couponDetails->amount_type=="Fixed"){
                        $couponAmount = $couponDetails->amount;
                    }else{
                        $couponAmount = $total_amount * ($couponDetails->amount/100);
                    }
                    $grand_total = $total_amount - $couponAmount;

                    // Add Coupon Code & Amount in Session Variables
                    Session::put('couponAmount',$couponAmount);
                    Session::put('couponCode',$data['code']);

                    $message = "Coupon code successfully applied. You are availing discount!";
                    $totalCartItems = totalCartItems();
                    $userCartItems = Cart::userCartItems();
                    return response()->json([
                        'status'=>true,
                        'message'=>$message,
                        'totalCartItems'=>$totalCartItems,
                        'couponAmount'=>$couponAmount,
                        'grand_total'=>$grand_total,
                        'view'=>(String)View::make('front.products.cart_items')->with(compact('userCartItems'))
                    ]); 

                }

            }
        }
    }

    public function checkout(Request $request){
        if($request->isMethod('post')){
            $data = $request->all();
            /*print_r($data); die;*/
            if(empty($data['address_id'])){
                $message = "Please select Delivery Address!";
                session::flash('error_message',$message);
                return redirect()->back();
            }
            if(empty($data['payment_gateway'])){
                $message = "Please select Payment Method!";
                session::flash('error_message',$message);
                return redirect()->back();
            }
            

            if($data['payment_gateway']=="COD"){
                $payment_method = "COD";
            }else{
                echo "Coming Soon"; die;
                $payment_method = "Prepaid";    
            }

            // Get Delvery Address from address_id
            $deliveryAddress = DeliveryAddress::where('id',$data['address_id'])->first()->toArray();
            /*dd($deliveryAddress); die;*/

            DB::beginTransaction();

            // Insert Order Details
            $order = new Order;
            $order->user_id = Auth::user()->id;
            $order->name = $deliveryAddress['name'];
            $order->address = $deliveryAddress['address'];
            $order->city = $deliveryAddress['city'];
            $order->state = $deliveryAddress['state'];
            $order->country = $deliveryAddress['country'];
            $order->pincode = $deliveryAddress['pincode'];
            $order->mobile = $deliveryAddress['mobile'];
            $order->email = Auth::user()->email;
            $order->shipping_charges = 0;
            $order->coupon_code = Session::get('couponCode');
            $order->coupon_amount = Session::get('couponAmount');
            $order->order_status = "New";
            $order->payment_method = $payment_method;
            $order->payment_gateway = $data['payment_gateway'];
            $order->grand_total = Session::get('grand_total');
            $order->save();

            // Get last Inserted Order Id
            $order_id = DB::getPdo()->lastInsertId();

            // Get User Cart Items
            $cartItems = Cart::where('user_id',Auth::user()->id)->get()->toArray();
            foreach ($cartItems as $key => $item) {
                $cartItem = new OrdersProduct;
                $cartItem->order_id = $order_id;
                $cartItem->user_id = Auth::user()->id;

                $getProductDetails = Product::select('product_code','product_name','product_color')->where('id',$item['product_id'])->first()->toArray();
                $cartItem->product_id = $item['product_id'];
                $cartItem->product_code = $getProductDetails['product_code'];
                $cartItem->product_name = $getProductDetails['product_name'];
                $cartItem->product_color = $getProductDetails['product_color'];
                $cartItem->product_size = $item['size'];
                $getDiscountedAttrPrice = Product::getDiscountedAttrPrice($item['product_id'],$item['size']);
                $cartItem->product_price = $getDiscountedAttrPrice['final_price'];
                $cartItem->product_qty = $item['quantity'];
                $cartItem->save();
            }

            // Insert Order id in Session Variable
            Session::put('order_id',$order_id);

            DB::commit();

            if($data['payment_gateway']=="COD"){

                // Send Order SMS
                $message = "Dear Customer, your order ".$order_id." has been successfully placed with StackDevelopers.in. We will intimate you once your order is shipped.";
                $mobile = Auth::user()->mobile;
                Sms::sendSms($message,$mobile);

                $orderDetails = Order::with('orders_products')->where('id',$order_id)->first()->toArray();
                /*echo "<pre>"; print_r($orderDetails); die;*/

                // Send Order Email
                $email = Auth::user()->email;
                $messageData = [
                    'email' => $email,
                    'name' => Auth::user()->name,
                    'order_id' => $order_id,
                    'orderDetails' => $orderDetails
                ];
                Mail::send('emails.order',$messageData,function($message) use($email){
                    $message->to($email)->subject('Order Placed - StackDevelopers.in');
                });

                return redirect('/thanks');
            }else{
                echo "Prepaid Method Coming Soon"; die;
            }

            echo "Order placed"; die;

        }


        $userCartItems = Cart::userCartItems();

        if(count($userCartItems)==0){
            $message = "Shopping Cart is empty! Please add products to checkout.";
            Session::put('error_message',$message);
            return redirect('cart');
        }


        $deliveryAddresses = DeliveryAddress::deliveryAddresses();
        return view('front.products.checkout')->with(compact('userCartItems','deliveryAddresses'));
    }

    public function thanks(){
        if(Session::has('order_id')){
            // Empty the User Cart
            Cart::where('user_id',Auth::user()->id)->delete();
            return view('front.products.thanks');    
        }else{
            return redirect('/cart');
        }        
    }

    public function addEditDeliveryAddress($id=null,Request $request){
        if($id==""){
            // Add Delivery Address
            $title = "Add Delivery Address";
            $address = new DeliveryAddress;
            $message = "Delivery Address added successfully!";
        }else{
            // Edit Delivery Address
            $title = "Edit Delivery Address";
            $address = DeliveryAddress::find($id);
            $message = "Delivery Address updated successfully!";
        }
        if($request->isMethod('post')){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/

            $rules = [
                'name' => 'required|regex:/^[\pL\s\-]+$/u',
                'address' => 'required',
                'city' => 'required|regex:/^[\pL\s\-]+$/u',
                'state' => 'required|regex:/^[\pL\s\-]+$/u',
                'country' => 'required',
                'pincode' => 'required|numeric|digits:6',
                'mobile' => 'required|numeric|digits:10',
            ];
            $customMessages = [
                'name.required' => 'Name is required',
                'name.regex' => 'Valid Name is required',
                'address.required' => 'Address is required',
                'city.required' => 'City is required',
                'city.regex' => 'Valid City is required',
                'state.required' => 'State is required',
                'state.regex' => 'Valid State is required',
                'country.required' => 'Country is required',
                'pincode.required' => 'Pincode is required',
                'pincode.numeric' => 'Valid Pincode is required',
                'pincode.digits' => 'Pincode must be of 6 digits',
                'mobile.required' => 'Mobile is required',
                'mobile.numeric' => 'Valid Mobile is required',
                'mobile.digits' => 'Mobile must be of 10 digits',
            ];
            $this->validate($request,$rules,$customMessages);

            $address->user_id = Auth::user()->id;
            $address->name = $data['name'];
            $address->address = $data['address'];
            $address->city = $data['city'];
            $address->state = $data['state'];
            $address->country = $data['country'];
            $address->pincode = $data['pincode'];
            $address->mobile = $data['mobile'];
            $address->save();
            Session::put('success_message',$message);
            return redirect('checkout');
        }
        $countries = Country::where('status',1)->get()->toArray();
        return view('front.products.add_edit_delivery_address')->with(compact('countries','title','address'));
    }

    public function deleteDeliveryAddress($id){
        DeliveryAddress::where('id',$id)->delete();
        $message = "Delivery Address deleted successfully!";
        Session::put('success_message',$message);
        return redirect()->back();
    }
}
