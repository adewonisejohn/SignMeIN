import face_recognition
import numpy as np
import sys


input = sys.argv[1]


student_face = face_recognition.load_image_file("./database/"+input)


try:
    student_face_encoding = face_recognition.face_encodings(student_face)[0]
    print(str(1))
except IndexError:
    print(str(0))


sys.stdout.flush()

    


    




