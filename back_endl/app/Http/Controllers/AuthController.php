<?php

namespace App\Http\Controllers;
use App\Models\Agence;
use App\Models\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    //register_agence
    public function register_agence(Request $request)
    {
        //validate fields
        $attrs = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|min:6|confirmed'
        ]);

        //create Agence
        $user = Agence::create([
            'name' => $attrs['name'],
            'email' => $attrs['email'],
            'password' => bcrypt($attrs['password'])
        ]);

        //return Agence & token in response
        return response([
            'user' => $user,
            'token' => $user->createToken('secret')->plainTextToken
        ], 200);
    }

    // login_agence
    public function login_agence(Request $request)
    {
        $fields = $request->validate([
            'email' => 'required|string',
            'password' => 'required|string'
        ]);
    
        // Check email
        $agence = Agence::where('email', $fields['email'])->first();
    
        // Check password
        if(!$agence || !Hash::check($fields['password'], $agence->password)) {
            return response([
                'message' => 'Bad creds'
            ], 403);
        }
    
       
    
        return response([
            'user' => $agence,
            'token' => $agence->createToken('secret')->plainTextToken
        ], 200);
    }
    

    //___________________login_client________________
    public function login_client(Request $request) {
        $fields = $request->validate([
            'email' => 'required|string',
            'password' => 'required|string'
        ]);
    
        // Check email
        $client = Client::where('email', $fields['email'])->first();
    
        // Check password
        if(!$client || !Hash::check($fields['password'], $client->password)) {
            return response([
                'message' => 'Bad creds'
            ], 403);
        }
    
        return response([
            'client' => $client,
            'token' => $client->createToken('secret')->plainTextToken
        ], 200);
    }

     //___________________register_client________________
    public function register_client(Request $request)
    {
        //validate fields
        $attrs = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|min:6|confirmed'
        ]);

        //create client
        $client = Client::create([
            'name' => $attrs['name'],
            'email' => $attrs['email'],
            'password' =>  Hash::make($request->password)
        ]);

        //return client & token in response
        return response([
            'client' => $client,
            'token' => $client->createToken('secret')->plainTextToken
        ], 200);
    }
    
    // logout user
    public function logout()
    {
        auth()->user()->tokens()->delete();
        return response([
            'message' => 'Logout success.'
        ], 200);
    }
   
    //___________________get information________________
    public function user()
    {
        return response([
            'user' => auth()->user()
        ], 200);
    }
   
 
}
