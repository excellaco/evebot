ChannelResponder = require '../utilities/channelResponder'

module.exports =
class CodeRed extends ChannelResponder

  constructor: (robot, msg)->
    channelId = process.env.CODERED_SLACK_CHANNEL_ID
    super(channelId, robot, msg)

  andonResponse: () ->
    @msg.send "@here CODE RED! \n Stop what you're doing. Find out what you can do to help."
