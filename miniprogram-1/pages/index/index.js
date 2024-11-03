// index.js
Page({
  data: {
    isPlayingMusic: false,
    bgm: null,
    music_url: 'musics/just-relax-11157.mp3',
    onReady: function(){
      this.bgm = wx.getBackgroundAudioManager()
      this.bgm.title = 'say goodbye to past life'
      this.bgm.epname = 'relax'
      this.bgm.onCanplay(() => {
          this.bgm.pause()
        })
      this.bgm.src = this.music_url
    },
    play: function(e){
      if(this.data.isPlayingMusic){
        this.bgm.pause()
      } else {
        this.bgm.play()
      }
      this.setData({
        isPlayingMusic: !this.data.isPlayingMusic
      })
    },
    callHusband: function(){
      wx.makePhoneCall({
        phoneNumber: '13700000000',
      })
    },
    callWife: function(){
      wx.makePhoneCall({
        phoneNumber: '13700000000',
      })
    }
  }
})
