<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\DeliveryAddress;

class DeliveryAddressTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $deliveryRecords = [
        	['id'=>1,'user_id'=>1,'name'=>'Amit Gupta','address'=>'Test 123','city'=>'New Delhi','state'=>'Delhi','country'=>'India','pincode'=>110001,'mobile'=>9800000000,'status'=>1],
        	['id'=>2,'user_id'=>1,'name'=>'Amit Gupta','address'=>'ABC - Mall Road','city'=>'New Delhi','state'=>'Delhi','country'=>'India','pincode'=>110001,'mobile'=>9800000000,'status'=>1]
        ];
        DeliveryAddress::insert($deliveryRecords);
    }
}
