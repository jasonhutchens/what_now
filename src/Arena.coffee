WhatNow = window.WhatNow

class Arena extends Phaser.State
  constructor:->
  preload:->

  create:->
    @game.physics.startSystem(Phaser.Physics.ARCADE)
    @game.input.gamepad.start()

    @game.world.setBounds(0, 0, 10000, 7500)

    @polluted = @game.add.sprite(0, 0, 'polluted')
    @polluted.width = 10000
    @polluted.height = 7500
    @polluted.alpha = 0.3
    @polluted.z = 0

    @ship = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'ship')
    @ship.anchor.set(0.5)
    @ship.z = 1
    @ship.angle = -90

    @game.physics.enable(@ship, Phaser.Physics.ARCADE)
    @ship.body.drag.set(70);
    @ship.body.maxVelocity.set(400);

    @game.camera.follow(@ship, 0)

    @pad = @game.input.gamepad.pad1

    @scale = 1

  render:->
    @camera.scale.x = @scale
    @camera.scale.y = @scale

  update:->
    @ship.body.angularVelocity = 0
    @ship.body.acceleration.set(0)

    if (@pad.isDown(Phaser.Gamepad.XBOX360_DPAD_LEFT) || @pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) < -0.1)
      @ship.body.angularVelocity = -200
    else if (@pad.isDown(Phaser.Gamepad.XBOX360_DPAD_RIGHT) || @pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) > 0.1)
      @ship.body.angularVelocity = 200

    thrust = 200 * @pad.buttonValue(Phaser.Gamepad.XBOX360_RIGHT_TRIGGER)
    @game.physics.arcade.accelerationFromRotation(@ship.rotation, thrust, @ship.body.acceleration)

    @scale = 1
    if @ship.body.speed > 200
      @scale = 0.6
    if @ship.body.speed > 390
      @scale = 0.3

    if @ship.x > 10000
      @ship.x = 0
    if @ship.x < 0
      @ship.x = 10000

    if @ship.y > 7500
      @ship.y = 0
    if @ship.y < 0
      @ship.y = 7500

  destroy:->

  done:=>
    @game.state.start('splash')

  _onDown:=>
    console.log 'down'

  _onAxis:(pad, axis, value)=>
    console.log 'axis'

WhatNow.Arena = Arena
