
import { initializeApp } from "firebase/app";
import { getStorage, ref , uploadBytes , getDownloadURL , deleteObject } from "firebase/storage";

const firebaseConfig = {
   // your config object
   // you get from firebase
   apiKey: "AIzaSyCVq_E2pZ5FD8Q6RWSKEmnjmZ8WVrh7PkA",
   authDomain: "proyectointegrador-e2212.firebaseapp.com",
   projectId: "proyectointegrador-e2212",
   storageBucket: "proyectointegrador-e2212.appspot.com",
   messagingSenderId: "4455056114",
   appId: "1:4455056114:web:aa0af31fa1f65548e9c66b",
   measurementId: "G-MDZRF01NHQ"
};


    async function saveFile(imagetoUpload){

        if(imagetoUpload == null) return ;

        const app = initializeApp(firebaseConfig);
        const storage = getStorage(app);
        let imageRef = ref(storage, `images/${imagetoUpload.name}`);

         let snapshot = await uploadBytes(imageRef, imagetoUpload) ;
        
         imageRef = ref(storage, snapshot.metadata.fullPath);
         let url = await getDownloadURL(imageRef);
         return  url ;
    };


  async function getFile(){

     const app = initializeApp(firebaseConfig);
     const storage = getStorage(app);
     const imageRef = ref(storage, `images/img1.jpg`);

     let url = await getDownloadURL(imageRef);
     return url;
  };


async function deleteFile(imagePath){

 const app = initializeApp(firebaseConfig);
 const storage = getStorage(app);
 const imageRef = ref(storage, imagePath);

   deleteObject(imageRef).then(() => {
      // File deleted successfully
   }).catch((error) => {
   // Uh-oh, an error occurred!
   });
  };

export {saveFile , getFile , deleteFile};