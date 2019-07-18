(function () {
  var _this = this
  var id = 1
  var callbacks = {}
  window.JsBridgeInvoke = function (result) {
    var callbackId = result.callbackId
    var data = result.data
    var success = result.success
    var message = result.message
    if (callbackId) {
      if (callbacks[callbackId]) {
        callbacks[callbackId]({data: data, success: success, message: message})
      }
    }
    return _this
  }
  window.JsBridgeBind = function (bridgeName, callback, params) {
    var msg = {success: false, data: null}
    if (typeof callback !== 'function') {
      return
    }
    if (!window.android && !window.callNativeBridgeApi) {
      msg.message = '请确认运行环境在"集客"App中'
      callback(msg)
      return
    }
    id += 1
    callbacks[id] = callback
    var data = {bridgeName: bridgeName, data: params || {}, callbackId: id}
    if (Object.prototype.hasOwnProperty.call(window, 'callNativeBridgeApi')) {
      window.callNativeBridgeApi(data)
    } else {
      if (Object.prototype.hasOwnProperty.call(window, 'android')) {
        window.android.callNativeBridgeApi(JSON.stringify(data))
      }
    }
  }
})()
