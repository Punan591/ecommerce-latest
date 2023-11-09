@extends('layouts.front_layout.front_layout')
@section('content')
<div class="span9">
	<ul class="breadcrumb">
		<li><a href="index.html">Home</a> <span class="divider">/</span></li>
		<li class="active">Login</li>
	</ul>
	<h3> My Account</h3>
	<hr class="soft"/>
	@if(Session::has('success_message'))
        <div class="alert alert-success" role="alert">
            {{ Session::get('success_message') }}
          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
    @endif
	@if(Session::has('error_message'))
        <div class="alert alert-danger" role="alert">
            {{ Session::get('error_message') }}
          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
    @endif
    @if ($errors->any())
	    <div class="alert alert-danger" style="margin-top: 10px;">
	        <ul>
	            @foreach ($errors->all() as $error)
	                <li>{{ $error }}</li>
	            @endforeach
	        </ul>
	    </div>
    @endif
	<div class="row">
		<div class="span4">
			<div class="well">
				<h5>CONTACT DETAILS</h5><br/>
				Enter your contact details<br/><br/>
				<form id="accountForm" action="{{ url('/account') }}" method="post">@csrf
					<div class="control-group">
						<label class="control-label" for="name">Name</label>
						<div class="controls">
							<input class="span3" type="text" id="name" name="name" placeholder="Enter Name" value="{{ $userDetails['name'] }}" required="" pattern="[A-Za-z]+">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="address">Address</label>
						<div class="controls">
							<input class="span3" type="text" id="address" name="address" placeholder="Enter Address" value="{{ $userDetails['address'] }}">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="city">City</label>
						<div class="controls">
							<input class="span3" type="text" id="city" name="city" placeholder="Enter City" value="{{ $userDetails['city'] }}">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="state">State</label>
						<div class="controls">
							<input class="span3" type="text" id="state" name="state" placeholder="Enter State" value="{{ $userDetails['state'] }}">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="country">Country</label>
						<div class="controls">
							<select class="span3" id="country" name="country">
								<option value="">Select Country</option>
								@foreach($countries as $country)
									<option value="{{ $country['country_name'] }}" @if($country['country_name']==$userDetails['country']) selected="" @endif>{{ $country['country_name'] }}</option>
								@endforeach
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="pincode">Pincode</label>
						<div class="controls">
							<input class="span3" type="text" id="pincode" name="pincode" placeholder="Enter Pincode" value="{{ $userDetails['pincode'] }}">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="mobile">Mobile</label>
						<div class="controls">
							<input class="span3" type="text" id="mobile" name="mobile" placeholder="Enter Mobile" value="{{ $userDetails['mobile'] }}">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="email">Email</label>
						<div class="controls">
							<input class="span3"  value="{{ $userDetails['email'] }}" readonly="">
						</div>
					</div>
					<div class="controls">
						<button type="submit" class="btn block">Update</button>
					</div>
				</form>
			</div>
		</div>
		<div class="span1"> &nbsp;</div>
		<div class="span4">
			<div class="well">
				<h5>UPDATE PASSWORD</h5>
				<form id="passwordForm" action="{{ url('/update-user-pwd') }}" method="post">@csrf
					<div class="control-group">
						<label class="control-label" for="current_pwd">Current Password</label>
						<div class="controls">
							<input class="span3" type="password" id="current_pwd" name="current_pwd" placeholder="Enter Current Password"><br>
							<span id="chkPwd"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="new_pwd">New Password</label>
						<div class="controls">
							<input class="span3" type="password" id="new_pwd" name="new_pwd" placeholder="Enter New Password">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="confirm_pwd">Confirm Password</label>
						<div class="controls">
							<input class="span3" type="password" id="confirm_pwd" name="confirm_pwd" placeholder="Confirm New Password">
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
							<button type="submit" class="btn">Update</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
@endsection