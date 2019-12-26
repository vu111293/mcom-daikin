// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';

// void showDownloadProgress(received, total) {
//   if (total != -1) {
//     print((received / total * 100).toStringAsFixed(0) + "%");
//   }
// }

// uploadImage(listImages, token) async {
//   var dio = Dio();
//   dio.options.baseUrl = "https://day2box.com:6002/api/v1/";
//   dio.options.headers["Authorization"] = token;

//   // dio.interceptors.add(LogInterceptor(requestBody: true));
//   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//       (HttpClient client) {
//     client.findProxy = (uri) {
//       //proxy all request to localhost:8888
//       return "PROXY localhost";
//     };
//     client.badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;
//   };
//   // dataImage = [];
//   // if (listImages.length === 0) resolve([]);
//   int index = -1;
//   List incommingUploadImages = [];
//   listImages.forEach((image) => {
//         if (image.uri.slice(0, 4) == 'http')
//           {
//             incommingUploadImages.add(image.uri),
//             index++,
//             if (index == listImages.length - 1)
//               {
//                 // resolve(dataImage)
//               }
//           }
//         else
//           {
//              try {
//     FormData formData = new FormData.from({
//       "files": UploadFileInfo(File("./example/upload.txt"), "upload.txt")
//     });
//     Response response = await dio.post(
//       "/info",
//       data: formData,
//     );
//     print(response);
//   } catch (e) {
//     print(e);
//   }
//           }
//       });
// }

// // export const uploadImage = (listImages, token) =>
// //   new Promise((resolve, reject) => {
// //     // console.log('poi updaload image listImages ban dau', listImages);

// //     // console.log('poi updaload image token ban dau', token);
// //     let dataImage = [];
// //     if (listImages.length === 0) resolve([]);
// //     let index = -1;
// //     listImages.forEach(image => {
// //       if (image.uri.slice(0, 4) === 'http') {
// //         dataImage.push(image.uri);
// //         index++;
// //         if (index === listImages.length - 1) {
// //           resolve(dataImage);
// //         }
// //       } else {
// //         const body = new FormData();
// //         const indexOfDot = image.uri.lastIndexOf('.');
// //         const fileName = `${image.uri.slice(indexOfDot - 1, image.uri.length)}.${image.type === 'video/mp4' ? 'mp4' : 'png'}`;
// //         console.log('hoang log filename', fileName);
// //         body.append('file', {
// //           uri: image.uri,
// //           name: fileName,
// //           type: 'multipart/form-data'
// //         });

// //         fetch(`${BASE_URL}file/upload`, {
// //           method: 'POST',
// //           headers: {
// //             'Authorization': `Bearer ${token}`
// //           },
// //           body
// //         })
// //           .then((res) => res.json())
// //           .then((res) => {
// //             if (res.code === 200) {
// //               dataImage.push(res.results.object.url);
// //             } else {
// //               reject(res);
// //             }
// //           })
// //           .catch(e => reject(e))
// //           .done(() => {
// //             index++;
// //             if (index === listImages.length - 1) {
// //               resolve(dataImage);
// //             }
// //           });
// //       }
// //     });
// //   });
