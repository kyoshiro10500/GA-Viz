#pragma once
#include <iostream>
#include <vector>
#include <stack>
#include <climits>

/*!
 * \brief Individu class : represents an individual
 */

class Individu
{
	private :
        int _number_mutation = 0 ; /*! The number of mutations of an individual*/
        int _number_crossover = 0 ; /*! The number of crossing-over of an individual*/
        int _number_buses; /*! The number of buses of an individual*/
        int _distance; /*! The distance of an individual*/
        double _scoreBuses ; /*! The score regarding buses of an individual (between 0 and 1)*/
        double _scoreDistance ; /*! The score regarding distance of an individual (between 0 and 1)*/
        int _gIdx ; /*! The unique index defining an individual*/
        int _parent1 = -1 ; /*! The global index of the first parent of an individual (-1 means no parent)*/
        int _parent2 = -1 ; /*! The global index of the second parent of an individual (-1 means no parent)*/
	public :
        //Constructor
        //! The default constructor of an empty individual
        /*!
         * Initialize the individual with empty variable
         */
		Individu();

        //! The copy constructor of an individual
        /*!
         * Creates an individual and copy every members of another individual
         */
        Individu(const Individu&) ;

        //Destructor
        //! The default destructor of an individual
        /*!
         * Destroy an individual by freeing every members of an individual
         */
		~Individu();

        //Setter
        //! Set the distance of an individual
        /*!
         * \param distance : the double corresponding to the value of the distance value of an individual
         */
		void setDistance(double distance);

        //! Set the number of buses of an individual
        /*!
         * \param number_buses : the int corresponding to the value of the number of buses of an individual
         */
		void setNumberBuses(int number_buses);

        //! Set the global index of an individual
        /*!
         * \param gIdx : the int corresponding to the value of the global index of an individual
         */
        void setGIdx(int gIdx) ;

        //! Set the first parent of an individual
        /*!
         * \param parent1 : the int corresponding to the value of the first parent of an individual
         */
        void setParent1(int parent1) ;

        //! Set the second parent of an individual
        /*!
         * \param parent2 : the int corresponding to the value of the second parent of an individual
         */
        void setParent2(int parent2) ;

        //! Set the number of mutations of an individual
        /*!
         * \param number_mutation : the int corresponding to the value of the number of mutations of an individual
         */
        void setNumberMutation(int number_mutation) ;

        //! Set the number of crossing over of an individual
        /*!
         * \param number_crossover : the int corresponding to the value of the number of crossing over of an individual
         */
        void setNumberCrossover(int number_crossover) ;

		//getter

        //! Get the boolean describing if an individual is mutated or not
        /*!
         * \return A bool which value is true if the individual is mutated
         */
		bool getMutation() const;

        //! Get the boolean describing if an individual have crossing over or not
        /*!
         * \return A bool which value is true if the individual has crossing over
         */
		bool getCrossing() const;

        //! Get the boolean describing if an individual is new or not
        /*!
         * \return A bool which value is true if the individual is nue
         */
		bool getNew() const;

        //! Get the number of buses of an individual
        /*!
         * \return An int representing the number of buses of an individual
         */
		int getNumberBuses() const;

        //! Get the distance of an individual
        /*!
         * \return A double representing the distance of an individual
         */
		double getDistance() const;

        //! Get the global score of an individual
        /*!
         * \return A double representing the global score of an individual (mean value between the two sorts of score)
         */
		double getScore() const;

        //! Get the global index of an individual
        /*!
         * \return An int representing the global index of an individual
         */
        int getGIdx() const ;

        //! Get the first parent of an individual
        /*!
         * \return An int representing the first parent of an individual (-1 if no parent)
         */
        int getParent1() const ;

        //! Get the second parent of an individual
        /*!
         * \return An int representing the second parent of an individual (-1 if no parent)
         */
        int getParent2() const ;

        //! Get the score regarding buses of an individual
        /*!
         * \return A double representing the score regarding buses of an individual (between 0 and 1)
         */
        double getScoreBuses() const ;

        //! Get the score regarding distance of an individual
        /*!
         * \return A double representing the score regarding distance of an individual (between 0 and 1)
         */
        double getScoreDistance() const ;

        //! Get the number of mutation of an individual
        /*!
         * \return An int representing the number of mutations of an individual
         */
        int getNumberMutation() const ;

        //! Get the number of crossing over of an individual
        /*!
         * \return An int representing the number of crossing over of an individual
         */
        int getNumberCrossover() const ;

		//Functions
        //! Calculate the score regarding buses and distance of an individual
        /*!
         * \param min_distance : a double representing the minimal distance of a population
         * \param min_number_buses : an int representing the minimal number of buses of a population
         * \param max_distance : a double representing the maximal distance of a population
         * \param max_buses : an int representing the maximal number of buses of a population
         */
        void calculateScore(double min_distance, int min_number_buses , int max_distance, int max_buses);
};
