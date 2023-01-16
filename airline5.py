from flask import Flask, render_template, request, jsonify
from model1 import *

app=Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI']='postgres://localhost/lecture4'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False

db.init_app(app)

@app.route('/')
def index():
    flights=Flight.query.all()
    return render_template('index.html',flights=flights)

@app.route('/book', methods=['POST'])
def Book():
    #get form information
    name=request.form.get('name')
    try:
        flight_id=int(request.form.get('flightid'))
    except ValueError:
        return render_template('err.html', message='Invalid flight ID')

    #check the flightid exist
    flight=Flight.query.get(flight_id)
    if flight is None:
        return render_template('err.html', message='Flight does not exist')

    #Now if flight exist then add passenger to flight
    flight.add_passenger(name)
    
    return render_template('success.html')

@app.route('/flights')
def flights():
    flights=Flight.query.all()
    return render_template('allf.html',allf=flights)

@app.route('/flights/<int:flight_id>')
def flight(flight_id):
    flight=Flight.query.get(flight_id)
    passengers=flight.passengers
    return render_template('flight.html', flight=flight, passengers=passengers)

@app.route('/api/flights/<int:flight_id>')
def flight_api(flight_id):

    flight=Flight.query.get(flight_id)
    if flight is None:
        return jsonify({"error":"Flight not found"}), 422

    passengers=flight.passengers
    names=[]
    for passenger in passengers:
        names.append(passenger.name)
    
    return jsonify({
        "origin":flight.origin,
        "destination":flight.destination,
        "duration":flight.duration,
        "passengers":names
    })


if __name__=='__main__':
    app.run(debug=True)