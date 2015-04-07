$ ->

    if App.controller is 'documents'

        # Set CodeMirror to use CDNjs for mode files - see ./loadmode.js
        CodeMirror.modeURL = "https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.1.0/mode/%N/%N.js"

        setEditorMode = (mode) ->
            editor.setOption 'mode', mode
            CodeMirror.autoLoadMode editor, mode

        form = $('.new_document,.edit_document')

        textarea = $('#document_content')
        modeSelect = $('#document_language')

        # Create a CodeMirror instance
        editor = CodeMirror document.body,
            theme: 'monokai-sublime'
            lineWrapping: true
            lineNumbers: true

        # If a form exists assume #new or #edit
        if form.length

            # Start focussed
            editor.focus()

            # Set initial value
            editor.setValue textarea.html()

            # Add modes to <select>
            for mode in CodeMirror.modeInfo
                modeSelect.append $("<option value='#{mode.mode}'>#{mode.name}</option>")

            # DOCUMENT_LANG was set in the application layout
            if DOCUMENT_LANG
                modeSelect.val DOCUMENT_LANG
            else
                modeSelect.val 'null' # null is plaintext

            # Change codemirror mode
            setEditorMode modeSelect.val()
            modeSelect.on 'change', ->
                setEditorMode modeSelect.val()

            # Add value back to form on submit
            form.on 'submit', ->
                textarea.html editor.getValue()

        # Otherwise assume #show
        else

            editor.setOption 'readOnly', true
            setEditorMode DOCUMENT_LANG

            documentContent = $('#document-content')
            editor.setValue documentContent.html()
            documentContent.remove()