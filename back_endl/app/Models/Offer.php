<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Offer extends Model
{     use HasFactory;
    
    protected $fillable = [
        'user_id',
    'price',
    'bedrooms',
    'addres',
    'area',
    'bathrooms',
    'kitchen',
    'garage',
    'description',
    
];
    //
    public function user(){
        return $this->belongsTo(agence::class);
    }
   
  
    public function comments()
    {
        return $this->hasMany(Comment::class);
    }
    public function images()
    {
        return $this->hasMany(Image::class);
    }

}
