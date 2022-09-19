# Weewx for Home Assistant

Hi! I developed this addon as a way to add Weewx to hassio as an addon. I managed to get it to work on hassio via MQTT, however I won't work on it any longer as I decided to use https://github.com/bachya/ecowitt2mqtt instead as it offered everything I needed, without the need for any more work on my part.

To use this as an addon, you should follow the guide for adding a custom addon into Home Assistant.  
Also, you'll need to configure correctly [Weewx Interceptor](https://github.com/matthewwall/weewx-interceptor) and [Weewx MQTT](https://github.com/matthewwall/weewx-mqtt).

Finally, you'll have to manually configure the MQTT sensors in HA that you want to listen to.

I won't be able to provide any help configuring those.

## Why ecowitt2mqtt?

I moved away from weewx for two reasons:

- It didn't offer some functionalities that I needed (mainly more frequent data publishing)
- Direct MQTT integration with HA without having to listen for the topics manually
- It appeared to me that "outsiders" [aren't welcome on the google forums](https://groups.google.com/g/weewx-user/c/RGOr9F-sFgM), as they deleted my messages without any specific reason.
