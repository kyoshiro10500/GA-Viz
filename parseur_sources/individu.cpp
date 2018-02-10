        #include "individu.h"
    #include <stack>

    //Constructor
    Individu::Individu() : _isMutated(false),_isNew(false),_isCrossing(false)
    {

    }

    Individu::Individu(const Individu& ind)
    {
        _isMutated = ind.getMutation() ;
        _isNew = ind.getNew() ;
        _isCrossing = ind.getCrossing() ;
        _distance = ind.getDistance();
        _number_buses = ind.getNumberBuses();
        _scoreBuses = ind.getScoreBuses() ;
        _scoreDistance = ind.getScoreDistance() ;
        _gIdx = ind.getGIdx() ;
        _parent1 = ind.getParent1() ;
        _parent2 = ind.getParent2() ;
    }

    //Destructor
    Individu::~Individu()
    {

    }

    //Setter
    void Individu::setDistance(double distance)
    {
        _distance = distance;
    }

    void Individu::setNumberBuses(int number_buses)
    {
        _number_buses = number_buses;
    }

    void Individu::setGIdx(int gIdx)
    {
        _gIdx = gIdx ;
    }

    void Individu::setMutation(bool isMutated)
    {
        _isMutated = isMutated ;
    }

    void Individu::setCrossing(bool isCrossing)
    {
        _isCrossing = isCrossing ;
    }

    void Individu::setIsNew(bool isNew)
    {
        _isNew = isNew ;
    }

    void Individu::setParent1(int parent1)
    {
        _parent1 = parent1 ;
    }

    void Individu::setParent2(int parent2)
    {
        _parent2 = parent2 ;
    }

    //Getter
    bool Individu::getMutation() const
    {
        return _isMutated;
    }

    bool Individu::getNew() const
    {
        return _isNew;
    }

    bool Individu::getCrossing() const
    {
        return _isCrossing;
    }

    int Individu::getGIdx() const
    {
        return _gIdx ;
    }

    int Individu::getNumberBuses() const
    {
        return _number_buses;
    }

    double Individu::getDistance() const
    {
        return _distance;
    }

    double Individu::getScore() const
    {
        return (_scoreBuses + _scoreDistance)/2.0 ;
    }

    int Individu::getParent1() const
    {
        return _parent1 ;
    }

    int Individu::getParent2() const
    {
        return _parent2 ;
    }

    double Individu::getScoreBuses() const
    {
        return _scoreBuses ;
    }

    double Individu::getScoreDistance() const
    {
        return _scoreDistance ;
    }

    //Operators
    std::ostream& operator<<(std::ostream& os, const Individu& individu)
    {
        os << "NUMBER BUSES : " << individu.getNumberBuses() << "\n"
            << "DISTANCE : " << individu.getDistance() << "\n"
            << "SCORE : " << individu.getScore() << "\n";
        return os;
    }

    //Functions
    void Individu::calculateScore(double min_distance, int min_number_buses, int max_distance, int max_buses)
    {
        //The score is the mean value between the score on distance and the score on number_buses regarding the minimum values
        _scoreBuses =(double) (_number_buses- max_buses) / (min_number_buses - max_buses) ;
        _scoreDistance = (double) (_distance - max_distance) / (min_distance - max_distance) ;
    }
