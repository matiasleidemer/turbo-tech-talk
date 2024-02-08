# myapp.rb
require 'sinatra'

get '/page_navigation' do
  sleep 2
  <<~HTML
  <h3 style="font-size: 32px;">Some other page</h3>
  <p style="margin-top: 12px; font-size: 24px;">#{Time.now.strftime("%H:%M:%S")}</p>
  HTML
end

get '/messages/messages_stream' do
  sleep 2

  # The content type important is. Without this, Turbo will NOT attempt to execute any stream
  # instructions. Sinatra will respond with the default content-type of "text/html" and Turbo
  # will look for a turbo-frame tag and then fail when it doesn't find it.
  content_type 'text/vnd.turbo-stream.html'

  <<~HTML
    <turbo-stream action="update" target="message_1">
      <template>
        <h3>Message 1 Form</h3>
      </template>
    </turbo-stream>

    <turbo-stream action="remove" target="message_2">
    </turbo-stream>

    <turbo-stream action="append" target="foobar">
      <template>
        <p>Still I got content</p>
      </template>
    </turbo-stream>
  HTML
end

get '/messages/edit' do
  sleep 1

  <<~HTML
    <h3>This is some content</h3>

    <turbo-frame id="message_3">
      <h3>Message 1 Form</h3>
    </turbo-frame>

    <turbo-frame id="message_2">
      <h3>Message 2 Form</h3>
    </turbo-frame>

    <h3>Some other content goes here</h3>
  HTML
end

get '/messages/edit_lazy' do
  sleep 2
  <<~HTML
    <turbo-frame id="message_3">
      <h3>Message 3 Form</h3>
      <p>I was lazily loaded
    </turbo-frame>
  HTML
end

get '/messages/edit_all' do
  <<~HTML
    <h3>This is some content</h3>

    <turbo-frame id="message_1">
      <h3>Message 1 Form</h3>
    </turbo-frame>

    <turbo-frame id="message_2">
      <h3>Message 2 Form</h3>
    </turbo-frame>

    <h3>Some other content goes here</h3>
  HTML
end
