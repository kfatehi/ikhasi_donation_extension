# ==UserScript==
# @name GithubExample
# @include http://*github*
# @include https://*github*
# @require jquery-1.9.1.min.js
# ==/UserScript==

$ = window.$.noConflict(true) # Required for Opera and IE

DONATE_BUTTON_HTML = """
  <li> 
    <a href='#' class='minibutton lighter upwards'>
       <span class='octicon octicon-beer'></span>
       <span class='text'>Donations (...)</span>
    </a>
  </li>
"""

class IkhasiAPI
  donations: (github_path) ->
    url = "http://ikhasi.io/api/v1/donations/github#{github_path}"
    console.log "IkhasiAPI: #{url}"
    return url

class DonationExtensions
  constructor: (@path) ->
    @api = new IkhasiAPI
    @donate_button = $(DONATE_BUTTON_HTML)
    @donate_button.click ->
      console.log 'Pop modal to accept Bitcoin'
    @donate_button.appendTo '.pagehead-actions'
    @update_donation_count()

  update_donation_count: ->
    $.getJSON @api.donations(@path), (data) ->
      if data.donation_count?
        @donate_button.find('.text').text(data.donation_count)
      else
        console.log "Could not get donation count from server. Got: "
        console.log data
        @donate_button.find('.text').text('?')

if $('.pagehead-actions').length
  new DonationExtensions(window.location.pathname)