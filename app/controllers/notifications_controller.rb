class NotificationsController < ApplicationController

   def create
    message= {
      icon: 'https://example.com/images/demos/icon-512x512.png',
      title: 'test from', 
      body:  'you got a new message',
      target_url: 'localhost:5000' 
    }
    Webpush.payload_send webpush_params(message)
    head :ok
   end


end
