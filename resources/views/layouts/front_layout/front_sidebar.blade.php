<?php
use App\Section;
$sections = Section::sections();
/*echo "<pre>"; print_r($sections); die;*/
?>
<div id="sidebar" class="span3" style="background-color:#0f171e;">
	<div class="well well-small" style="background-color:#0f171e;"><a id="myCart" style="color:white;" href="{{ url('cart') }}"><img src="{{ asset('images/front_images/ico-cart.png') }}" alt="cart"><span class="totalCartItems">{{ totalCartItems() }}</span> Items in your cart</a></div>
	<ul id="sideManu" class="nav nav-tabs nav-stacked">
		@foreach($sections as $section)
			@if(count($section['categories'])>0)
				<li class="subMenu"><a>{{ $section['name'] }}</a>
					@foreach($section['categories'] as $category)
					<ul>
						<li><a href="{{ url($category['url']) }}"><i class="icon-chevron-right"></i><strong>{{ $category['category_name'] }}</strong></a></li>
						@foreach($category['subcategories'] as $subcategory)
							<li><a href="{{ url($subcategory['url']) }}"><i class="icon-chevron-right"></i>{{ $subcategory['category_name'] }}</a></li>
						@endforeach
					</ul>
					@endforeach
				</li>
			@endif
		@endforeach
	</ul>

	
</div>