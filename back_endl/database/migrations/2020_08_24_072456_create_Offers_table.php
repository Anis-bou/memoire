<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOffersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('Offers', function (Blueprint $table) {
            $table->id();
            $table->string('numberphone');
            $table->string('price');
            $table->integer('user_id');
            $table->string('bedrooms');
            $table->string('addres');
            $table->string('area');
            $table->string('bathrooms');
            $table->string('kitchen');
            $table->string('garage');
            $table->string('categorie');
            $table->string('operation');
            $table->string('latitude');
            $table->string('longitude');
            $table->string('name_agence');
            $table->string('image')->nullable();
            $table->string('description');
            $table->timestamps();
           //  $table->unsignedBigInteger('agence_id');
           // $table->foreign('agence_id')->references('id')->on('agences');

        });
    }
    /*             var price;
  var addres;
  var bedrooms;
  var bathrooms;
  var area;
  var kitchen;
  var description; */
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('Offers');
    }
}
