import face_recognition

student_face = face_recognition.load_image_file("./images/current_image.jpeg")

image2 = face_recognition.load_image_file("database/idris.jpeg")

student_face_encoding = face_recognition.face_encodings(student_face)[0]

print(str(type(student_face_encoding)))

#print(str(student_face_encoding))