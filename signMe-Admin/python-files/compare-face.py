import face_recognition
import numpy as np
import sys



input = sys.argv[1]
index = int(sys.argv[2])
length = int(sys.argv[3])


student_face = face_recognition.load_image_file("./images/current_image.jpeg")
unknown_face = face_recognition.load_image_file("./database/"+input)



student_face_encoding = face_recognition.face_encodings(student_face)[0]
unkown_encoding = face_recognition.face_encodings(unknown_face)[0]

results = face_recognition.compare_faces([student_face_encoding],unkown_encoding)

if(results[0]==True):
    print(str(input))
    
elif results[0]==False and length-length==index:
    print(str(1))
else:
    print(str(0))
    






sys.stdout.flush()

