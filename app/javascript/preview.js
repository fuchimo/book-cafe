if (document.URL.match(/new/) || document.URL.match(/edit/)) {
  document.addEventListener('DOMContentLoaded', function(){
    const imgList = document.getElementById('preview-image');

    const createImage = (blob) => {
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('class', 'card-img-top');
      imgList.appendChild(blobImage);
    };

    document.getElementById('book-image').addEventListener('change', function(e) {
      const imageContent = document.querySelector('img');
      
      if (imageContent) {
        imageContent.remove();
      }

      const imageNow = document.getElementById('image-now');
      if (imageNow) {
        imageNow.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImage(blob);
    });
  });
};