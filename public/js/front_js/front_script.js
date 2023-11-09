$(document).ready(function(){

	$.ajaxSetup({
	    headers: {
	        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
	    }
	});

	$("#sort").on('change',function(){
		var sort = $(this).val();
		var fabric = get_filter('fabric');
		var sleeve = get_filter('sleeve');
		var pattern = get_filter('pattern');
		var fit = get_filter('fit');
		var occasion = get_filter('occasion');
		var url = $("#url").val();
		$.ajax({
			url:url,
			method:"post",
			data:{fabric:fabric,sleeve:sleeve,pattern:pattern,fit:fit,occasion:occasion,sort:sort,url:url},
			success:function(data){
				$('.filter_products').html(data);
			}
		})
	});

	$(".fabric").on('click',function(){
		var fabric = get_filter('fabric');
		var sleeve = get_filter('sleeve');
		var pattern = get_filter('pattern');
		var fit = get_filter('fit');
		var occasion = get_filter('occasion');
		var sort = $("#sort option:selected").val();
		var url = $("#url").val();	
			$.ajax({
			url:url,
			method:"post",
			data:{fabric:fabric,sleeve:sleeve,pattern:pattern,fit:fit,occasion:occasion,sort:sort,url:url},
			success:function(data){
				$('.filter_products').html(data);
			}
		})
	});

	$(".sleeve").on('click',function(){
		var fabric = get_filter('fabric');
		var sleeve = get_filter('sleeve');
		var pattern = get_filter('pattern');
		var fit = get_filter('fit');
		var occasion = get_filter('occasion');
		var sort = $("#sort option:selected").val();
		var url = $("#url").val();	
			$.ajax({
			url:url,
			method:"post",
			data:{fabric:fabric,sleeve:sleeve,pattern:pattern,fit:fit,occasion:occasion,sort:sort,url:url},
			success:function(data){
				$('.filter_products').html(data);
			}
		})
	});

	$(".pattern").on('click',function(){
		var fabric = get_filter('fabric');
		var sleeve = get_filter('sleeve');
		var pattern = get_filter('pattern');
		var fit = get_filter('fit');
		var occasion = get_filter('occasion');
		var sort = $("#sort option:selected").val();
		var url = $("#url").val();	
			$.ajax({
			url:url,
			method:"post",
			data:{fabric:fabric,sleeve:sleeve,pattern:pattern,fit:fit,occasion:occasion,sort:sort,url:url},
			success:function(data){
				$('.filter_products').html(data);
			}
		})
	});

	$(".fit").on('click',function(){
		var fabric = get_filter('fabric');
		var sleeve = get_filter('sleeve');
		var pattern = get_filter('pattern');
		var fit = get_filter('fit');
		var occasion = get_filter('occasion');
		var sort = $("#sort option:selected").val();
		var url = $("#url").val();	
			$.ajax({
			url:url,
			method:"post",
			data:{fabric:fabric,sleeve:sleeve,pattern:pattern,fit:fit,occasion:occasion,sort:sort,url:url},
			success:function(data){
				$('.filter_products').html(data);
			}
		})
	});

	$(".occasion").on('click',function(){
		var fabric = get_filter('fabric');
		var sleeve = get_filter('sleeve');
		var pattern = get_filter('pattern');
		var fit = get_filter('fit');
		var occasion = get_filter('occasion');
		var sort = $("#sort option:selected").val();
		var url = $("#url").val();	
			$.ajax({
			url:url,
			method:"post",
			data:{fabric:fabric,sleeve:sleeve,pattern:pattern,fit:fit,occasion:occasion,sort:sort,url:url},
			success:function(data){
				$('.filter_products').html(data);
			}
		})
	});

	function get_filter(class_name){
		var filter = [];
		$('.'+class_name+':checked').each(function(){
			filter.push($(this).val());
		});
		return filter;
	}

	$("#getPrice").change(function(){
		var size = $(this).val();
		if(size==""){
			alert("Please select Size");
			return false;
		}
		var product_id = $(this).attr("product-id");
		$.ajax({
			url:'/get-product-price',
			data:{size:size,product_id:product_id},
			type:'post',
			success:function(resp){
				if(resp['discount']>0){
					$(".getAttrPrice").html("<del>Rs. "+resp['product_price']+"</del> Rs."+resp['final_price']);	
				}else{
					$(".getAttrPrice").html("Rs. "+resp['product_price']);	
				}
				
			},error:function(){
				alert("Error");
			}
		});
	});

	// Update Cart Items
	$(document).on('click','.btnItemUpdate',function(){
		if($(this).hasClass('qtyMinus')){
			// if qtyMinus button gets clicked by User
			var quantity = $(this).prev().val();
			if(quantity<=1){
				alert("Item quantity must be 1 or greater!");
				return false;
			}else{
				new_qty = parseInt(quantity)-1;
			}
		}
		if($(this).hasClass('qtyPlus')){
			// if qtyPlus button gets clicked by User
			var quantity = $(this).prev().prev().val();
			new_qty = parseInt(quantity)+1;
		}
		var cartid = $(this).data('cartid');
		$.ajax({
			data:{"cartid":cartid,"qty":new_qty},
			url:'/update-cart-item-qty',
			type:'post',
			success:function(resp){
				if(resp.status==false){
					alert(resp.message);
				}
				$(".totalCartItems").html(resp.totalCartItems);
				$("#AppendCartItems").html(resp.view);
			},error:function(){
				alert("Error");
			}
		});
	});

	// Delete Cart Items
	$(document).on('click','.btnItemDelete',function(){
		var cartid = $(this).data('cartid');
		var result = confirm("Want to delete this Cart Item");
		if(result){
			$.ajax({
				data:{"cartid":cartid},
				url:'/delete-cart-item',
				type:'post',
				success:function(resp){
					$(".totalCartItems").html(resp.totalCartItems);
					$("#AppendCartItems").html(resp.view);
				},error:function(){
					alert("Error");
				}
			});	
		}
	});

	// validate register form on keyup and submit
	$("#registerForm").validate({
		rules: {
			name: "required",
			mobile: {
				required: true,
				minlength: 10,
				maxlength: 10,
				digits: true
			},
			email: {
				required: true,
				email: true,
				remote: "check-email"
			},
			password: {
				required: true,
				minlength: 6
			}
		},
		messages: {
			name: "Please enter your Name",
			mobile: {
				required: "Please enter your Mobile",
				minlength: "Your mobile must consist of 10 digits",
				maxlength: "Your mobile must consist of 10 digits",
				digits: "Please enter your valid Mobile"
			},
			email: {
				required: "Please enter your Email",
				email: "Please enter your valid Email",
				remote: "Email already exists"
			},
			password: {
				required: "Please choose your password",
				minlength: "Your password must be at least 6 characters long"
			}
		}
	});

	// validate login form on keyup and submit
	$("#loginForm").validate({
		rules: {
			email: {
				required: true,
				email: true
			},
			password: {
				required: true,
				minlength: 6
			}
		},
		messages: {
			email: {
				required: "Please enter your Email",
				email: "Please enter your valid Email"
			},
			password: {
				required: "Please enter your password",
				minlength: "Your password must be at least 6 characters long"
			}
		}
	});

	// validate account form on keyup and submit
	$("#accountForm").validate({
		rules: {
			name: {
				required: true,
				accept: "[a-zA-Z]+"
			},
			mobile: {
				required: true,
				minlength: 10,
				maxlength: 10,
				digits: true
			}
		},
		messages: {
			name: {
				required: "Please enter your Name",
				accept: "Please enter valid Name"
			}, 
			mobile: {
				minlength: "Your mobile must consist of 10 digits",
				maxlength: "Your mobile must consist of 10 digits",
				digits: "Please enter your valid Mobile"
			}
		}
	});

	// validate account form on keyup and submit
	$("#passwordForm").validate({
		rules: {
			current_pwd: {
				required: true,
				minlength:6,
				maxlength:20
			},
			new_pwd: {
				required: true,
				minlength:6,
				maxlength:20
			},
			confirm_pwd: {
				required: true,
				minlength:6,
				maxlength:20,
				equalTo:"#new_pwd"
			}
		}
	});

	// Check Current User Password
	$("#current_pwd").keyup(function(){
		var current_pwd = $(this).val();
		$.ajax({
			type:'post',
			url:'/check-user-pwd',
			data:{current_pwd:current_pwd},
			success:function(resp){
				/*alert(resp);*/
				if(resp=="false"){
					$("#chkPwd").html("<font color='red'>Current Password is Incorrect</font>");
				}else if(resp=="true"){
					$("#chkPwd").html("<font color='green'>Current Password is Correct</font>");
				}
			},error:function(){
				alert("Error");
			}
		});
	});

	// Apply Coupon
	$("#ApplyCoupon").submit(function(){
		var user = $(this).attr("user");
		if(user==1){
			// do nothing
		}else{
			alert("Please login to apply Coupon!");
			return false;
		}
		var code = $("#code").val();
		$.ajax({
			type:'post',
			data:{code:code},
			url:'/apply-coupon',
			success:function(resp){
				if(resp.message!=""){
					alert(resp.message);
				}
				$(".totalCartItems").html(resp.totalCartItems);
				$("#AppendCartItems").html(resp.view);
				if(resp.couponAmount>=0){
					$(".couponAmount").text("Rs."+resp.couponAmount);	
				}else{
					$(".couponAmount").text("Rs.0");
				}
				if(resp.grand_total>=0){
					$(".grand_total").text("Rs."+resp.grand_total);
				}
			},error:function(){
				alert("Error");
			}
		})
	});

	// Delete Delivery Address
	$(document).on('click','.addressDelete',function(){
		var result = confirm("Want to delete this Address?");
		if(!result){
			return false;
		}
	});


});