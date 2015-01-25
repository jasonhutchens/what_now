WhatNow = window.WhatNow

class Splash extends Phaser.State
  constructor:->

  create:->
    @game.stage.backgroundColor = '#FFFFFF'

    @bros = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'bros')
    @bros.body = null
    @bros.scale.setTo(0.6, 0.6)
    @bros.anchor.setTo(0.5, 0.5)
    @bros.alpha = 0

    @arse = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'arse')
    @arse.body = null
    @arse.scale.setTo(0.6, 0.6)
    @arse.anchor.setTo(0.5, 0.5)
    @arse.alpha = 0

    arse_fade_in = @game.add.tween(@arse)
    arse_fade_in.to({ alpha: 1 }, 1000, Phaser.Easing.Linear.None, false)

    arse_fade_out = @game.add.tween(@arse)
    arse_fade_out.to({ alpha: 0 }, 1000, Phaser.Easing.Linear.None, false)

    arse_fade_in.onComplete.addOnce(=> arse_fade_out.start())
    arse_fade_out.onComplete.addOnce(=> bros_fade_in.start())

    bros_fade_in = @game.add.tween(@bros)
    bros_fade_in.to({ alpha: 1 }, 1000, Phaser.Easing.Linear.None, false)

    bros_fade_out = @game.add.tween(@bros)
    bros_fade_out.to({ alpha: 0 }, 1000, Phaser.Easing.Linear.None, false)

    bros_fade_in.onComplete.addOnce(=> bros_fade_out.start())
    bros_fade_out.onComplete.addOnce(@done)

    arse_fade_in.start()

  destroy:->
    destroy(@bros)

  done:=>
    @game.state.start('arena')

WhatNow.Splash = Splash
