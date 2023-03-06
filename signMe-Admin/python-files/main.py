import face_recognition

student_face = face_recognition.load_image_file("./images/current_image.png")

image2 = face_recognition.load_image_file("database/idris.jpeg")

student_face_encoding = face_recognition.face_encodings(student_face)[0]
unknown_encoding = face_recognition.face_encodings(image2)[0]

results = face_recognition.compare_faces([student_face_encoding], unknown_encoding)

print(results)