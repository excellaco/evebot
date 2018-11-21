CodeRed = require "./code_red/codeRed"
FauxPas = require "./faux_pas/fauxPas"
BigSillies = require "./big_sillies/bigSillies"
BitsPlease = require "./bits_please/bitsPlease"
module.exports = (robot) ->

  # TODO Add a listener for "andon-help" and print a list of the below commands
  robot.hear /andon-help/i, (msg) ->
    msg.send "\
    *Andon Cord Help*\n\n \
    Use the word `andon` and it will respond appropriately for that channel.\n \
    `@evebot` must be added to the channel, and have a response coded for that channel.\n \
    "

  robot.hear /^( *andon.*|.*andon *)$/i, (msg) ->
    slackRoom = msg.envelope.room
    console.log("Message sent: ")
    console.log(msg.envelope.message.text)
    if slackRoom == process.env.CODE_RED_SLACK_CHANNEL_ID
      codeRedAndon(msg)
    if slackRoom == process.env.FAUXPAS_SLACK_CHANNEL_ID
      fauxPasAndon(msg)
    if slackRoom == process.env.BIGSILLIES_SLACK_CHANNEL_ID
      bigSilliesAndon(msg)
    if slackRoom == process.env.BITSPLEASE_SLACK_CHANNEL_ID
      bitsPleaseAndon(msg)

  robot.hear /^( *andoff.*|.*andoff *)$/i, (msg) ->
    slackRoom = msg.envelope.room
    if slackRoom == process.env.BIGSILLIES_SLACK_CHANNEL_ID
      bigSilliesAndoff(msg)
    if slackRoom == process.env.FAUXPAS_SLACK_CHANNEL_ID
      fauxPasAndoff(msg)
    if slackRoom == process.env.BITSPLEASE_SLACK_CHANNEL_ID
      bitsPleaseAndoff(msg)

  robot.hear /^( *sillyOn.*|.*sillyOn *)$/i, (msg) ->
    slackRoom = msg.envelope.room
    if slackRoom == process.env.BIGSILLIES_SLACK_CHANNEL_ID
      bigSilliesLights(msg)

  robot.hear /^( *sillyOff.*|.*sillyOff *)$/i, (msg) ->
    slackRoom = msg.envelope.room
    if slackRoom == process.env.BIGSILLIES_SLACK_CHANNEL_ID
      bigSilliesLightsOff(msg)

  codeRedAndon = (msg) ->
    codeRed = new CodeRed(robot, msg)
    codeRed.andonResponse()
    bigSillies = new BigSillies(robot, msg)
    bigSillies.lights();
    fauxPas = new FauxPas(robot, msg)
    fauxPas.light();
    bitsPlease = new BitsPlease(robot, msg)
    bitsPlease.lights()

  fauxPasAndon = (msg) ->
    text = msg.envelope.message.text
    regex = /^((andon)+.*)*(.*(andon) *)*$/i
    if (regex.test(text))
      fauxPas = new FauxPas(robot, msg)
      fauxPas.lightsOn();

  fauxPasAndoff = (msg) ->
    fauxPas = new FauxPas(robot, msg)
    fauxPas.lightsOff()

  bigSilliesAndon = (msg) ->
    bigSillies = new BigSillies(robot, msg)
    bigSillies.lightsOn();

  bigSilliesAndoff = (msg) ->
    bigSillies = new BigSillies(robot, msg)
    bigSillies.lightsOff();

  bigSilliesLights = (msg) ->
    bigSillies = new BigSillies(robot, msg)
    bigSillies.lights();

  bigSilliesLightsOff = (msg) ->
    bigSillies = new BigSillies(robot, msg)
    bigSillies.lightsOff();

  bitsPleaseAndon = (msg) ->
    bitsPlease = new BitsPlease(robot, msg)
    bitsPlease.lightsOn()

  bitsPleaseAndoff = (msg) ->
    bitsPlease = new BitsPlease(robot, msg)
    bitsPlease.lightsOff()
