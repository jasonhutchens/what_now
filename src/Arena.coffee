WhatNow = window.WhatNow

class Arena extends Phaser.State
  constructor:->
  preload:->

  create:->
    @game.input.gamepad.start()

    @game.world.setBounds(0, 0, 10000, 7500);

    @polluted = @game.add.sprite(0, 0, 'polluted')
    @polluted.width = 10000
    @polluted.height = 7500
    @polluted.alpha = 0.3
    @polluted.z = 0

    @ship = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'ship')
    @ship.z = 1

    @game.camera.follow(@ship, 0)

    @pad = @game.input.gamepad.pad1

  render:->
    @game.debug.cameraInfo(@game.camera, 500, 32);
    @game.debug.spriteInfo(@ship, 32, 32);

  update:->
    if (@pad.isDown(Phaser.Gamepad.XBOX360_DPAD_LEFT) || @pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) < -0.1)
      @ship.x--
    else if (@pad.isDown(Phaser.Gamepad.XBOX360_DPAD_RIGHT) || @pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) > 0.1)
      @ship.x++

    if (@pad.isDown(Phaser.Gamepad.XBOX360_DPAD_UP) || @pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) < -0.1)
      @ship.y--
    else if (@pad.isDown(Phaser.Gamepad.XBOX360_DPAD_DOWN) || @pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) > 0.1)
      @ship.y++

  destroy:->

  done:=>
    @game.state.start('splash')

  _onDown:=>
    console.log 'down'

  _onAxis:(pad, axis, value)=>
    console.log 'axis'

WhatNow.Arena = Arena
