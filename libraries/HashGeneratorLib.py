from robot.api.deco import keyword

import hashlib
import datetime

class HashGeneratorLib:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    @keyword("Generate hash")
    def get_score(*args):
        key_parts = [
            str(datetime.datetime.now())
        ]

        key = "uid:" + hashlib.md5("".join(key_parts).encode('utf-8')).hexdigest()
        return key


