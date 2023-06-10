ClassicEditor
    .create( document.querySelector( '#txtContent' ), {
        ckfinder: {
            uploadUrl : '/img/chapstory'
        }
    } )
    .then(editor => {
        console.log('Editor was initialized');
    })
    .catch( error => {
        console.error( error );
    } );
CKEDITOR.editorConfig=function(config){
    config.enterMode=CKEDITOR.ENTER_BR
}
