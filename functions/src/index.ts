import * as functions from 'firebase-functions';
import * as firebaseAdmin from 'firebase-admin';


export const createUserOgp = functions.https.onRequest(async (req, res) => {
    const userId = req.path.split("/")[2];
    const fireStore = firebaseAdmin.firestore();

    try {
        await firebaseAdmin.auth().getUser(userId);
        const user = await fireStore.collection('users').doc(userId).get();
        const userData = user.data();
        const cardType = "summary";
        const pass = "https://opg-sample.web.app/_user/" + userId;
        res.set("Cache-Control", "public, max-age=600, s-maxage=600");
        const html = createHtml(userData?.userName,userData?.imageUrl,userData?.profile,cardType,pass);
        res.status(200).send(html);
    }
    catch (error) {
        res.status(404).send("404 Not Found");
    }
   });

   export const createPlanOgp = functions.https.onRequest(async (req, res) => {
    const planId = req.path.split("/")[2];
    const fireStore = firebaseAdmin.firestore();

    try {
        await firebaseAdmin.auth().getUser(planId);
        const user = await fireStore.collection('users').doc(planId).get();
        const planData = user.data();
        const cardType = "summary_large_image";
        const pass = "https://opg-sample.web.app/_plan/" + planId;

        const titleStyle = "c_fit,w_1200,h_400,l_text:Sawarabi%20Gothic_100_style_bold_align_center";
        const descriptionStyle = '/y_250,l_text:Sawarabi%20Gothic_45_style_light_align_center:';
        const ogpImageUrl = "https://res.cloudinary.com/dz68snhp6/image/upload/" + titleStyle + planData?.title + descriptionStyle + planData?.description + "/v1620095546/ogp-background_ffibhc.jpg";
        res.set("Cache-Control", "public, max-age=600, s-maxage=600");
        const html = createHtml(planData?.title,ogpImageUrl,planData?.description,cardType,pass);
        res.status(200).send(html);
    }
    catch (error) {
        res.status(404).send("404 Not Found");
    }
   });

   const createHtml = (title: String, imageUrl: String,description:String,cardType: String,path: String) => {
    return `<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>CodeBoy</title>
    <meta property="og:title" content="${title}">
    <meta property="og:image" content="${imageUrl}">
    <meta property="og:description" content="${description}">
    <meta property="og:url" content="https://opg-sample.web.app/">
    <meta property="og:type" content="article">
    <meta property="og:site_name" content="OGP-sample">
    <meta name="twitter:site" content="${title}">
    <meta name="twitter:card" content="${cardType}">
    <meta name="twitter:title" content="${title}">
    <meta name="twitter:image" content="${imageUrl}">
    <meta name="twitter:description" content="${description}">
  </head>
  <body>
    <script type="text/javascript">window.location="${path}";</script>
  </body>
</html>
`
};