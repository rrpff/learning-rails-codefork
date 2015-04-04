modes = ["apl","asciiarmor","asterisk","clike","clojure","cmake","cobol","coffeescript","commonlisp","css","cypher","d","dart","diff","django","dockerfile","dtd","dylan","ebnf","ecl","eiffel","erlang","forth","fortran","gas","gfm","gherkin","go","groovy","haml","haskell","haxe","htmlembedded","htmlmixed","http","idl","index","html","jade","javascript","jinja2","julia","kotlin","livescript","lua","markdown","meta","js","mirc","mllike","modelica","nginx","ntriples","octave","pascal","pegjs","perl","php","pig","properties","puppet","python","q","r","rpm","rst","ruby","rust","sass","scheme","shell","sieve","slim","smalltalk","smarty","solr","soy","sparql","spreadsheet","sql","stex","stylus","tcl","textile","tiddlywiki","tiki","toml","tornado","troff","turtle","vb","vbscript","velocity","verilog","xml","xquery","yaml","z80"]

setTextareaValue = ->
    textarea.html editor.getValue()

setEditorMode = (name) ->
    loadMode name
    editor.setOption 'mode', name

loadMode = (name) ->
    script = $("<script>").appendTo $('body')
    script.src = "/assets/modes/#{name}/#{name}.js"

form = $('#new_document,#edit_document')
textarea = $('#document_content')
modeSelect = $('#document_language')

$ ->

    if form.length

        # Create a CodeMirror instance
        editor = CodeMirror document.body,
            value: textarea.html()
            theme: 'Glacier'
            mode: 'ruby'
            lineNumbers: true

        # Start focussed
        editor.focus()

        for mode in modes
            modeSelect.append $("<option value='#{mode}'>#{mode}</option>")

        # Change codemirror mode
        modeSelect.on 'change', (ev) ->
            setEditorMode modeSelect.value()

        # Add value back to form on submit
        form.on 'submit', setTextareaValue