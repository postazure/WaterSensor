# AeroGarden Water Sensor SMS service

Receive a text message when your water level decreases. Remember to feed and water your plants!

Particle Photon -> Webhook -> Twilio -> SMS


![](https://s-media-cache-ak0.pinimg.com/originals/be/d4/db/bed4dbc655e7e17bf7abe2c1acc2b984.gif)


Uses a Particle.io Photon and webhooks.

Note: sensor.ino and all ruby files are needed for version 1 (no webhooks, just long polling). Version 2 uses the Particle.io webhook integration and requires no database and no polling.
