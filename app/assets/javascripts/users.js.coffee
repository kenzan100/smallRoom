# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  #for users/show
  if $('#urge_add_to_home_screen_on_iOS').attr("value")
    console.log "hoge"
    addToHome.show(true)
  
  if $('form#new_progre #auto_done').attr("value")
    if $('input#todays_your_last_progre_done_at').length == 0
      $('html body div:first').hide().after("<div class='container'>now, sending your action..</p>")
      $('form#new_progre').submit()
    
  #for users/index
  $('form#new_user').hide()
  $('div#and_you h1 a').click (event)->
    $('form#new_user').toggle()
    
  #for identities/new
  $('input#my_custom').on 'change keydown', (evt) ->
    console.log $(this).data("source").indexOf($(this).val())
    console.log $(this).parent('div.control-group')
    if $(this).data("source").indexOf($(this).val()) >= 0
      $(this).parents('div.control-group').addClass("success").removeClass("warning")
      $(this).next('p.help-block').text("you're good to go!")
    else
      $(this).parents('div.control-group').addClass("warning").removeClass("success")
      $(this).next('p.help-block').text("you're creating brand-new custom. you may want to stick with existing ones. if so, type something else above again.")
      
  
