import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt; 
// import 'package:file_picker/file_picker.dart'; 
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';

class DocumentController extends GetxController {
  TextEditingController documentTitleController = TextEditingController();
  TextEditingController documetnIdNumberController = TextEditingController();
  TextEditingController documentNoteController = TextEditingController();

  late TextEditingController documentTitleEdittingController =
      TextEditingController();
  late TextEditingController documetnIdNumberEdittingController =
      TextEditingController();
  late TextEditingController documentNoteEdittingController =
      TextEditingController();

  var addedPasswordList = [].obs;
  var addedPasswordTitleList = [].obs;
  var addDocumentIsLoading = false.obs;

  // Future<(Uint8List?, String)> addFile() async {
    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(withData: true);
    // print("Hello");
    // print(result);
    // PlatformFile file = result!.files.first;

    // print(file.name);
    // print(file.bytes);
    // print(file.size);
    // print(file.extension);
    // return (file.bytes, file.name);
    //print(file.path);
    /*
    if (result != null) {
      
      File file1 = File(result.paths[0]!);
      print(file1.path);
    
      
  
      return file.bytes;
    } else {
      print("Cancelled by User");
      // User canceled the picker
    }
    */
  // }

  Future<(String, String)> encryptFile() async {
    var (fileBytes, fileName) = await addFile();
    print(fileBytes.toString());
    print(fileName);
    print("Doing");
    const storage = FlutterSecureStorage();
    var mainKeyValue = await storage.read(key: mainKey);
    var ivStr = await storage.read(key: ivKey);
    print("2");
    encrypt.Key key = encrypt.Key.fromBase16(mainKeyValue!.substring(0, 64));
    final iv = encrypt.IV.fromBase16(ivStr!);
    //storage.write(key: "iv", value: iv.base16);
    encrypt.Encrypter encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    encrypt.Encrypted encrypted = encrypter.encryptBytes(fileBytes!, iv: iv);
    print("3");
    return (encrypted.base64, fileName);
    /*
    print(decrypted);

    Directory tempDir = await getTemporaryDirectory();
    //var tempDir = ;
    print("Hello");
    //print(tempDir.toString());
    String tempPath = tempDir.path;
    var filePath = "$tempPath/$fileName";
    //var filePath = "/$fileName";
    print(filePath);
    //var directory = Directory.current;
    File newFile =
        await File(filePath).writeAsBytes(Uint8List.fromList(decrypted));
    //File newFile = await File(directory.path).writeAsBytes(Uint8List.fromList(decrypted));

    OpenFile.open(newFile.path);
    print("Hello");
    //print(newFile.path);
    //OpenFile.open(newFile.path);
    /*
    File("/data/user/0/com.example.hashing/cache/file_picker/1722862803964/passbook.pdf")
        .open();
    newFile.open(mode: FileMode.read);
    File(tempPath + "/passbook.pdf");
    var openedFile = newFile.open();
    openedFile.asStream;
    */
    print("Hello");
    */
  }

  addDocumentToDatabase(context) async {
    var store = firestore.collection(documentCollection).doc();
    await store.set({
      'd_user': currentUser!.uid,
      'd_title': documentTitleController.text,
      'd_id_number': documetnIdNumberController.text,
      'd_note': documentNoteController.text,
      'd_favourites': false,
      'd_docs': FieldValue.arrayUnion(addedPasswordList),
      'd_created_At': FieldValue.serverTimestamp(),
      'd_updated_at': FieldValue.serverTimestamp(),
      'd_tags': FieldValue.arrayUnion([
        'Education',
        'Social',
      ]),
    }); 
    documentTitleController.clear();
    documetnIdNumberController.clear();
    documentNoteController.clear();
    addedPasswordList.clear();
    addedPasswordTitleList.clear(); 
    addDocumentIsLoading(false); 
  }
}
