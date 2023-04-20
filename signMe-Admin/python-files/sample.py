import face_recognition
import numpy as np
import sys





student_face = face_recognition.load_image_file("../images/register.jpeg")
unknown_face = face_recognition.load_image_file("../database/1680020630665.jpeg")


try:

    student_face_encoding = face_recognition.face_encodings(student_face)[0]
    unkown_encoding = face_recognition.face_encodings(unknown_face)[0]
except IndexError:
    print("index error")


results = face_recognition.compare_faces([student_face_encoding],unkown_encoding)

print(results)
    






sys.stdout.flush()

