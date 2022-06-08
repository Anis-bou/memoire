<?php

namespace App\Http\Controllers;

use App\Models\Image;
use Facade\FlareClient\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
class ImageController extends Controller
{
    public function fetch($id){
        $image = Image::find($id);
        return Storage::download($image->url);
    }
    
}
