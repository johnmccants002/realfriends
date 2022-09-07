const functions = require("firebase-functions");
const admin = require('firebase-admin');

admin.initializeApp();


const spawn = require('child-process-promise').spawn;
const path = require('path');
const os = require('os');
const fs = require('fs');



// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
exports.addMessage = functions.https.onRequest(async (req, res) => {
    // Grab the text parameter.
    const original = req.query.text;
    // Push the new message into Firestore using the Firebase Admin SDK.
    const writeResult = await admin.firestore().collection('messages').add({original: original});
    // Send back a message that we've successfully written the message
    res.json({result: `Message with ID: ${writeResult.id} added.`});
  });

exports.makeUppercase = functions.firestore.document('/messages/{documentId}')
    .onCreate((snap, context) => {
        const original = snap.data().original;

        functions.logger.log('Uppercasing', context.params.documentId, original);

        const uppercase = original.toUpperCase();

        return snap.ref.set({uppercase}, {merge: true});

    });


    exports.generateThumbnail = functions.storage.object().onFinalize(async (object) => {
        // [END generateThumbnailTrigger]
          // [START eventAttributes]
          console.log("In generate thumbnail function")
          const fileBucket = object.bucket; // The Storage bucket that contains the file.
          const filePath = object.name; // File path in the bucket.
          const contentType = object.contentType; // File content type.
          const metageneration = object.metageneration; // Number of times metadata has been generated. New objects have a value of 1.
          // [END eventAttributes]
        
          // [START stopConditions]
          // Exit if this is triggered on a file that is not an image.
          if (!contentType.startsWith('image/')) {
            return functions.logger.log('This is not an image.');
          }
        
          // Get the file name.
          const fileName = path.basename(filePath);
          // Exit if the image is already a thumbnail.
          if (fileName.startsWith('thumb_')) {
            return functions.logger.log('Already a Thumbnail.');
          }
          // [END stopConditions]
        
          // [START thumbnailGeneration]
          // Download file from bucket.
          const bucket = admin.storage().bucket(fileBucket);
          const tempFilePath = path.join(os.tmpdir(), fileName);
          console.log(tempFilePath, "<--- Temp File Path");
          const metadata = {
            contentType: contentType,
          };
          await bucket.file(filePath).download({destination: tempFilePath});
          functions.logger.log('Image downloaded locally to', tempFilePath);
          // Generate a thumbnail using ImageMagick.
          await spawn('convert', [tempFilePath, '-thumbnail', '200x200>', tempFilePath]);
          functions.logger.log('Thumbnail created at', tempFilePath);
          // We add a 'thumb_' prefix to thumbnails file name. That's where we'll upload the thumbnail.
          const thumbFileName = `thumb_${fileName}`;
          const thumbFilePath = path.join(path.dirname(filePath), thumbFileName);
          // Uploading the thumbnail.
          await bucket.upload(tempFilePath, {
            destination: thumbFilePath,
            metadata: metadata,
          });
          // Once the thumbnail has been uploaded delete the local file to free up disk space.
          return fs.unlinkSync(tempFilePath);
          // [END thumbnailGeneration]
        });


