        #include "individu.h"
    #include <stack>

    //Constructor
    Individu::Individu()
    {

    }

    Individu::Individu(const Individu& ind)
    {
        _distance = ind.getDistance();
        _number_buses = ind.getNumberBuses();
        _scoreBuses = ind.getScoreBuses() ;
        _scoreDistance = ind.getScoreDistance() ;
        _number_mutation = ind.getNumberCrossover() ;
        _number_crossover = ind.getNumberMutation() ;
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

    void Individu::setNumberMutation(int number_mutation)
    {
        _number_mutation = number_mutation ;
    }

    void Individu::setNumberCrossover(int number_crossover)
    {
        _number_crossover = number_crossover ;
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
        return _number_mutation != 0 ;
    }

    bool Individu::getNew() const
    {
        return _parent1 != -1 || _parent2 != -1 ;
    }

    bool Individu::getCrossing() const
    {
        return _number_crossover != 0 ;
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

    int Individu::getNumberMutation() const
    {
        return _number_mutation ;
    }

    int Individu::getNumberCrossover() const
    {
        return _number_crossover ;
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
