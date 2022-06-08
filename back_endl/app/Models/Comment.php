<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class Comment extends Model
{
    use HasFactory;

    protected $fillable = [
        'comment',
        'name',
        'user_id',
        'offer_id'
    ];

    public function user()
    {
        return $this->belongsTo(Agence::class);
        //return $this->belongsTo(client::class);
        
        
    }
}
