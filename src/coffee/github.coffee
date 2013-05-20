# ==UserScript==
# @name GithubExample
# @include http://*github*
# @include https://*github*
# @require jquery-1.9.1.min.js
# ==/UserScript==

$ = window.$.noConflict(true) # Required for Opera and IE

contribute_button = $("""
  <li> 
    <a href='#' class='minibutton js-toggler-target fork-button lighter upwards'>
       <span class='octicon octicon-git-branch-create'></span>
       <span class='text'>Contribute</span>
    </a>
  </li>
  """)

contribute_button.click ->
  alert "Contribute!"

contribute_button.appendTo '.pagehead-actions'