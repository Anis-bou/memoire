<?php


use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ImageController;
use App\Http\Controllers\OffersController;
use App\Http\Controllers\CommentController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/


// agence
Route::post('/register', [AuthController::class, 'register_agence']);//register_agence
Route::post('/login', [AuthController::class, 'login_agence']);//login_agence
//______________client
Route::post('/register_client', [AuthController::class, 'register_client']);//register_client
Route::post('/login_client', [AuthController::class, 'login_client']);//login_client
// Protected Routes
Route::apiResource('offers', OffersController::class);
Route::get('images/{id}',[ImageController::class, 'fetch']);
Route::delete('destroy_image/{id}',[ImageController::class, 'destroy_image']);
//Route::get('images/{id}',[OffersController::class, 'fetch']);
Route::group(['middleware' => ['auth:sanctum']], function() {
   //________agence_________________//
   Route::get('/user', [AuthController::class, 'user']);
    Route::post('/offer', [OffersController::class, 'store']); //add offer
    Route::put('/offer/{id}', [OffersController::class, 'update']); // update offer
    Route::delete('/offer/{id}', [OffersController::class, 'destroy']);//delete offer
    Route::put('/user', [AuthController::class, 'update']);
    //____________________//   
    Route::get('/offer', [OffersController::class, 'list_offer']); 
    Route::get('/myoffer', [OffersController::class, 'myoffer']);// all offer
   
Route::get('/posts/{id}/comments', [CommentController::class, 'index']); // all comments of a post
Route::post('/posts/{id}/comments', [CommentController::class, 'store']); // create comment on a post
Route::put('/comments/{id}', [CommentController::class, 'update']); // update a comment
Route::delete('/comments/{id}', [CommentController::class, 'destroy']); // delete a comment
Route::post('/logout', [AuthController::class, 'logout']);
});

