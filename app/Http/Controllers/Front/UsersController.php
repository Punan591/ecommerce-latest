<?php

namespace App\Http\Controllers\Front;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Http\Request;
use App\Country;
use App\User;
use App\Cart;
use App\Sms;
use Auth;
use Session;

class UsersController extends Controller
{
    public function loginRegister(){
    	return view('front.users.login_register');
    }

    public function registerUser(Request $request){
    	if($request->isMethod('post')){
            Session::forget('error_message');
            Session::forget('success_message');
    		$data = $request->all();
    		/*echo "<pre>"; print_r($data); die;*/
    		// Check if User already exists
    		$userCount = User::where('email',$data['email'])->count();
    		if($userCount>0){
    			$message = "Email already exists!";
    			session::flash('error_message',$message);
    			return redirect()->back();
    		}else{
    			// Register the User
    			$user = new User;
    			$user->name = $data['name'];
    			$user->mobile = $data['mobile'];
    			$user->email = $data['email'];
    			$user->password = bcrypt($data['password']);
    			$user->status = 0;
    			$user->save();

                // Send Confirmation Email
                $email = $data['email'];
                $messageData = [
                    'email' => $data['email'],
                    'name' => $data['name'],
                    'code' => base64_encode($data['email'])
                ];
                Mail::send('emails.confirmation',$messageData,function($message) use($email){
                    $message->to($email)->subject('Confirm your E-commerce Account');
                });

                // Redirect Back with Success Message
                $message = "Please confirm your email to activate your account!";
                Session::put('success_message',$message);
                return redirect()->back();

    			/*if(Auth::attempt(['email'=>$data['email'],'password'=>$data['password']])){

                    // Update User Cart with user id 
                    if(!empty(Session::get('session_id'))){
                        $user_id = Auth::user()->id;
                        $session_id = Session::get('session_id');
                        Cart::where('session_id',$session_id)->update(['user_id'=>$user_id]);
                    }

                    // Send Register SMS
                    $message = "Dear Customer, you have been successfully registered with E-com Website. Login to your account to access orders and available offers."
                    $mobile = $data['mobile'];
                    Sms::sendSms($message,$mobile);

                    // Send Register Email
                    $email = $data['email'];
                    $messageData = ['name'=>$data['name'],'mobile'=>$data['mobile'],'email'=>$data['email']];
                    Mail::send('emails.register',$messageData,function($message) use($email){
                        $message->to($email)->subject('Welcome to E-commerce Website');
                    });
                    
    				return redirect('casual-t-shirts');
    			}*/
    		}
    	}
    }

    public function confirmAccount($email){
        Session::forget('error_message');
        Session::forget('success_message');

        // Decode User Email
        $email = base64_decode($email);
        
        // Check User Email exists
        $userCount = User::where('email',$email)->count();
        if($userCount>0){
            // User Email is already activated or not
            $userDetails = User::where('email',$email)->first();
            if($userDetails->status == 1){
                $message = "Your Email account is already activated. You can login.";
                Session::put('error_message',$message);
                return redirect('login-register');
            }else{
                // Update User Status to 1 to activate account
                User::where('email',$email)->update(['status'=>1]);

                // Send Register SMS
                /*$message = "Dear Customer, you have been successfully registered with E-com Website. Login to your account to access orders and available offers."
                $mobile = $userDetails['mobile'];
                Sms::sendSms($message,$mobile);*/

                // Send Register Email
                $messageData = ['name'=>$userDetails['name'],'mobile'=>$userDetails['mobile'],'email'=>$email];
                Mail::send('emails.register',$messageData,function($message) use($email){
                    $message->to($email)->subject('Welcome to E-commerce Website');
                });

                // Redirect to Login/Register page with Success message
                $message = "Your Email account is activated. You can login now.";
                Session::put('success_message',$message);
                return redirect('login-register');

            }
        }else{
            abort(404);
        }
    }

    public function checkEmail(Request $request){
        // Check if email already exists
        $data = $request->all();
        $emailCount = User::where('email',$data['email'])->count();
        if($emailCount>0){
            return "false";
        }else{
            return "true";
        }
    }

    public function loginUser(Request $request){
        if($request->isMethod('post')){
            Session::forget('error_message');
            Session::forget('success_message');
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/
            if(Auth::attempt(['email'=>$data['email'],'password'=>$data['password']])){
                // Check Email is activated or not
                $userStatus = User::where('email',$data['email'])->first();
                if($userStatus->status == 0){
                    Auth::logout();
                    $message = "Your account is not activated yet! Please confirm your email to activate!";
                    Session::put('error_message',$message);
                    return redirect()->back();
                }
                // Update User Cart with user id 
                if(!empty(Session::get('session_id'))){
                    $user_id = Auth::user()->id;
                    $session_id = Session::get('session_id');
                    Cart::where('session_id',$session_id)->update(['user_id'=>$user_id]);
                }

                return redirect('/cart');
            }else{
                $message = "Invalid Username or Password";
                Session::flash('error_message',$message);
                return redirect()->back();
            }
        }
    }

    public function logoutUser(){
    	Auth::logout();
    	return redirect('/');
    }

    public function forgotPassword(Request $request){
        if($request->isMethod('post')){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/
            $emailCount = User::where('email',$data['email'])->count();
            if($emailCount==0){
                $message = "Email does not exists!";
                Session::put('error_message','Email does not exists!');
                Session::forget('success_message');
                return redirect()->back();
            }

            // Generate Random Password
            $random_password = str_random(8);

            // Encode/Secure Password
            $new_password = bcrypt($random_password);

            // Update Password
            User::where('email',$data['email'])->update(['password'=>$new_password]);

            // Get User Name
            $userName = User::select('name')->where('email',$data['email'])->first();

            // Send Forgot Password Email
            $email = $data['email'];
            $name = $userName->name;
            $messageData = [
                'email' => $email,
                'name' => $name,
                'password' => $random_password
            ];
            Mail::send('emails.forgot_password',$messageData,function($message)use($email){
                $message->to($email)->subject('New Password - E-commerce Website');
            });

            // Redirect to Login/Register Page with Success message
            $message = "Please check your email for new Password!";
            Session::put('success_message',$message);
            Session::forget('error_message');
            return redirect('login-register');
        }
        return view('front.users.forgot_password');
    }

    public function account(Request $request){
        $user_id = Auth::user()->id;
        $userDetails = User::find($user_id)->toArray();
        $countries = Country::where('status',1)->get()->toArray();

        if($request->isMethod('post')){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/

            Session::forget('error_message');
            Session::forget('success_message');

            $rules = [
                'name' => 'required|regex:/^[\pL\s\-]+$/u',
                'mobile' => 'required|numeric',
            ];
            $customMessages = [
                'name.required' => 'Name is required',
                'name.regex' => 'Valid Name is required',
                'mobile.required' => 'Mobile is required',
            ];
            $this->validate($request,$rules,$customMessages);

            $user = User::find($user_id);
            $user->name = $data['name'];
            $user->address = $data['address'];
            $user->city = $data['city'];
            $user->state = $data['state'];
            $user->country = $data['country'];
            $user->pincode = $data['pincode'];
            $user->mobile = $data['mobile'];
            $user->save();
            $message = "Your account details has been updated successfully!";
            Session::put('success_message',$message);
            return redirect()->back();
        }

        return view('front.users.account')->with(compact('userDetails','countries'));
    }

    public function chkUserPassword(Request $request){
        if($request->isMethod('post')){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/
            $user_id = Auth::User()->id;
            $chkPassword = User::select('password')->where('id',$user_id)->first();
            if(Hash::check($data['current_pwd'],$chkPassword->password)){
                return "true";
            }else{
                return "false";
            }
        }
    }

    public function updateUserPassword(Request $request){
        if($request->isMethod('post')){
            $data = $request->all();
            /*echo "<pre>"; print_r($data); die;*/
            $user_id = Auth::User()->id;
            $chkPassword = User::select('password')->where('id',$user_id)->first();
            if(Hash::check($data['current_pwd'],$chkPassword->password)){
                // Update Current Password
                $new_pwd = bcrypt($data['new_pwd']);
                User::where('id',$user_id)->update(['password'=>$new_pwd]);
                $message = "Password updated successfully!";
                Session::put('success_message',$message);
                Session::forget('error_message');
                return redirect()->back();
            }else{
                $message = "Current Password is Incorrect!";
                Session::put('error_message',$message);
                Session::forget('success_message');
                return redirect()->back();
            }
        }
    }

}
