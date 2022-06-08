<?php

namespace App\Http\Controllers;


use App\Models\Image;

use App\Models\Offer;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;


class OffersController extends Controller
{
  // get all offers
  public function index(Request $request)
    {
        return Offer::orderBy('created_at', 'desc')->with(['images'])->get();
    }
 
  public function show($id)
  {
      return Offer::with(['images'])->find($id);
  }
  public function myoffer()
  {
      return response([
          'offers' => Offer::where('user_id',Auth::user()->id)->orderBy('id','desc')->get()    
      ], 200);
  }

  // create a offer
  public function store(Request $request)
  {     
    
    $this->validate($request, [
        'numberphone' => 'required|string',
        'price' => 'required|string',
        'bedrooms' => 'required|string',
        'addres' => 'required|string',
        'area' => 'required|string',
        'bathrooms' => 'required|string',
        'kitchen' => 'required|string',
        'garage' => 'required|string',
        'description' => 'required|string',
        'categorie' => 'required|string',
        'operation' => 'required|string',
        'name_agence' => 'required|string',
    ]);
 
    $offer = new Offer;
    $offer->user_id = Auth::user()->id;
    $offer->numberphone = $request->numberphone;
    $offer->description = $request->description;
    $offer->addres = $request->addres;
    $offer->area = $request->area;
    $offer->price = $request->price;
    $offer->bathrooms = $request->bathrooms;
    $offer->kitchen = $request->kitchen;
    $offer->garage = $request->garage;
    $offer->bedrooms = $request->bedrooms;
    $offer->categorie = $request->categorie;
    $offer->operation = $request->operation;
    $offer->latitude = $request->latitude;
    $offer->longitude = $request->longitude;
    $offer->name_agence = $request->name_agence;
    //$offer->image = $request->image;
     $offer->save();
    if ($request->hasFile('image')) {
        $originalImage = $request->file('image');
        // Resize the image
        //$resizedImage = resizeImage($originalImage);
        $originalImage->store('public/images/offers');
        Storage::disk('public')->put('images/offers/' . $offer->id . '.jpg', $originalImage);

    } else if($request->hasFile('images')){
        
        foreach ($request->file('images') as $imagefile) {
            $path = $imagefile->store('public/images/offers/'. $offer->id);
            $image = new Image;
            $image->url = $path;
           
            $image->offer_id = $offer->id;
            $image->save();
          }
    }
  return response('Offer created '.$offer->id, 201);
   

}
/* get images*/
public function fetch($image){

       
    return Storage::download('public/images/offers/'.$image);
    
}

  public function destroy($id)
  {
      $post = Offer::find($id);

      if(!$post)
      {
          return response([
              'message' => 'offer not found.'
          ], 403);
      }

      if($post->user_id != auth()->user()->id)
      {
          return response([
              'message' => 'Permission denied.'
          ], 403);
      }
      $post->delete();

      return response([
          'message' => 'Post deleted.'
      ], 200);
  }
  // update a offer
  public function update(Request $request, $id)
  {
      $offer = Offer::find($id);

      if(!$offer)
      {
          return response([
              'message' => 'offer not found.'
          ], 403);
      }

      if($offer->user_id != auth()->user()->id)
      {
          return response([
              'message' => 'Permission denied.'
          ], 403);
      }

      //validate fields
      $attrs = $request->validate([
          'price' => 'required|string',
          'bedrooms' => 'required|string',
          'addres' => 'required|string',
          'area' => 'required|string',
          'bathrooms' => 'required|string',
          'kitchen' => 'required|string',
          'garage' => 'required|string',
          'description' => 'required|string',
          'name_agence' => 'required|string',

      ]);
      $offer->update([
          'price' => $attrs['price'],
          'bedrooms' => $attrs['bedrooms'],
          'addres' => $attrs['addres'],
          'area' => $attrs['area'],
          'bathrooms' => $attrs['bathrooms'],
          'kitchen' => $attrs['kitchen'],
          'garage' => $attrs['garage'],
          'description' => $attrs['description'],
          'name_agence' => $attrs['name_agence'],
      ]);
      return response([
          'message' => 'offer updated.',
          'post' => $offer
      ], 200);
  }
 
}
