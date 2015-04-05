$ ->

    # Set CodeMirror to use CDNjs for mode files - see ./loadmode.js
    CodeMirror.modeURL = "https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.1.0/mode/%N/%N.js"

    setEditorMode = ->
        mode = modeSelect.val()
        editor.setOption 'mode', mode
        CodeMirror.autoLoadMode editor, mode

    form = $('#new_document,#edit_document')
    textarea = $('#document_content')
    modeSelect = $('#document_language')

    if form.length

        # Create a CodeMirror instance
        editor = CodeMirror document.body,
            value: textarea.html()
            theme: 'Glacier'
            mode: 'ruby'
            lineNumbers: true

        # Start focussed
        editor.focus()

        # Add modes to <select>
        for mode in CodeMirror.modeInfo
            modeSelect.append $("<option value='#{mode.mode}'>#{mode.name}</option>")

        # document was set in the form view
        if document and document.language
            modeSelect.val document.language
        else
            modeSelect.val 'null' # null is plaintext

        # Change codemirror mode
        setEditorMode()
        modeSelect.on 'change', setEditorMode

        # Add value back to form on submit
        form.on 'submit', ->
            textarea.html editor.getValue()