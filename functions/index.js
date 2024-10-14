const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.autoMoveDocuments = functions.pubsub.schedule("0 0 * * *") // Можно указать конкретное время: ('15 00 * * *') для 15:00
    .timeZone("Asia/Tashkent") // Укажите ваш часовой пояс
    .onRun(async () => {
        const db = admin.firestore();
        const sourceCollection = db.collection("Buyurtmalar"); // Исходная коллекция
        const targetCollection = db.collection("ArchivedOrders"); // Целевая коллекция

        try {
            // Получаем все документы из исходной коллекции
            const snapshot = await sourceCollection.get();
            const batch = db.batch(); // Используем batch для выполнения нескольких операций

            snapshot.forEach(doc => {
                const docData = doc.data(); // Получаем данные документа

                // Перемещаем документ в целевую коллекцию
                const newDocRef = targetCollection.doc(doc.id); // Создаем документ с тем же ID
                batch.set(newDocRef, docData); // Сохраняем в целевую коллекцию

                // Удаляем документ из исходной коллекции
                batch.delete(doc.ref);
            });

            // Применяем все изменения
            await batch.commit();
            console.log("Документы успешно перемещены и удалены");
        } catch (error) {
            console.error("Ошибка при перемещении документов:", error);
        }
    });

// /**
//  * Import function triggers from their respective submodules:
//  *
//  * const {onCall} = require("firebase-functions/v2/https");
//  * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
//  *
//  * See a full list of supported triggers at https://firebase.google.com/docs/functions
//  */

// const { onRequest } = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started

// // exports.helloWorld = onRequest((request, response) => {
// //   logger.info("Hello logs!", {structuredData: true});
// //   response.send("Hello from Firebase!");
// // });
// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// admin.initializeApp();

// exports.autoDeleteOrders = functions.pubsub.schedule('0 16 * * *') // Запуск каждый день в 20:15
//     .timeZone('Asia/Tashkent') // Установите ваш часовой пояс
//     .onRun(async (context) => {
//         const db = admin.firestore();
//         const ordersRef = db.collection('Buyurtmalar'); // Основная коллекция заказов
//         const archivedOrdersRef = db.collection('archivedOrders'); // Коллекция для архивированных заказов

//         const snapshot = await ordersRef.get();
//         const batch = db.batch();

//         snapshot.forEach(doc => {
//             const orderData = doc.data();
//             // Сохраняем заказ в архивную коллекцию
//             const newOrderRef = archivedOrdersRef.doc(doc.id);
//             batch.set(newOrderRef, orderData);

//             // Упаковываем удаление заказа
//             batch.delete(doc.ref);
//         });

//         await batch.commit();
//         console.log('Завершено автоматическое удаление и архивирование заказов');
//     });
