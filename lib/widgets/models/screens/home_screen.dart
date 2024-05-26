// import 'package:flutter/material.dart';
// import 'package:netflix/api/api.dart';
// import 'package:netflix/widgets/models/movie.dart';
// import 'package:netflix/widgets/movie_slider.dart';
// import 'package:netflix/widgets/trending.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late Future<List<Movies>> trendingMovies;
//   late Future<List<Movies>> topRatedMovies;
//   late Future<List<Movies>> upcomingMovies;

//   @override
//   void initState() {
//     super.initState();
//     trendingMovies = Api().getTrendingMovies();
//     topRatedMovies = Api().getTopRatedMovies();
//     upcomingMovies = Api().getUpcomingMovies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Image.asset(
//           'asset/05cItXL96l4LE9n02WfDR0h-5.webp',
//           height: 120,
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Trending Movies',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             FutureBuilder<List<Movies>>(
//               future: trendingMovies,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return  SizedBox(
//                     child: FutureBuilder(
//                       future: trendingMovies,
//                       builder: (context,snapshot){
//                         if(snapshot.hasError){
//                           return Center(child: Text(snapshot.error.toString()
//                           ),
//                           );
//                         }else if(snapshot.hasData){
                          
//                           return TrendingSlider(snapshot: snapshot,);
//                         }else{
//                           return (Center(
//                             child: CircularProgressIndicator(),
//                           )
//                           );
//                         }
//                       },
//                     ),
//                   );                 
//                 }
//               },
//             ),
//             SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Top rated movies',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400, 
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             SizedBox(
//                     child: FutureBuilder(
//                       future: topRatedMovies,
//                       builder: (context,snapshot){
//                         if(snapshot.hasError){
//                           return Center(child: Text(snapshot.error.toString()
//                           ),
//                           );
//                         }else if(snapshot.hasData){
                          
//                           return 
//                           MovieSlider(snapshot: snapshot);
//                         }else{
//                           return (Center(
//                             child: CircularProgressIndicator(),
//                           )
//                           );
//                         }
//                       },
//                     ),
//                   ),  
//             SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Upcoming movies',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             SizedBox(
//                     child: FutureBuilder(
//                       future: upcomingMovies,
//                       builder: (context,snapshot){
//                         if(snapshot.hasError){
//                           return Center(child: Text(snapshot.error.toString()
//                           ),
//                           );
//                         }else if(snapshot.hasData){
                          
//                           return MovieSlider(snapshot: snapshot,);
//                         }else{
//                           return (Center(
//                             child: CircularProgressIndicator(),
//                           )
//                           );
//                         }
//                       },
//                     ),
//                   ), 
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/widgets/models/movie.dart';
import 'package:netflix/widgets/movie_slider.dart';
import 'package:netflix/widgets/trending.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movies>> trendingMovies;
  late Future<List<Movies>> topRatedMovies;
  late Future<List<Movies>> upcomingMovies;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'asset/05cItXL96l4LE9n02WfDR0h-5.webp',
          height: 120,
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(),
          _buildSearchContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Trending Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 30),
          FutureBuilder<List<Movies>>(
            future: trendingMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SizedBox(
                  child: FutureBuilder(
                    future: trendingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return TrendingSlider(snapshot: snapshot);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
              }
            },
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Top Rated Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 30),
          FutureBuilder<List<Movies>>(
            future: topRatedMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SizedBox(
                  child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MovieSlider(snapshot: snapshot);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
              }
            },
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Upcoming Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 30),
          FutureBuilder<List<Movies>>(
            future: upcomingMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SizedBox(
                  child: FutureBuilder(
                    future: upcomingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MovieSlider(snapshot: snapshot);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchContent() {
    return Center(
      child: Text(
        'Search Page',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
