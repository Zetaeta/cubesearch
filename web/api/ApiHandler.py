from flask_restful import Api, Resource, reqparse


class ApiHandler(Resource):
    def get(self):
        return {'result_status': 'success', 'message': 'hello world'}
