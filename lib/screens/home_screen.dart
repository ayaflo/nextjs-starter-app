import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../providers/auth_provider.dart';
import 'create_recipe_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0 
          ? const Text('Trending posts')
          : const Text('What\'s yummy today?'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // TODO: Navigate to profile screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFilterChip('Posts', 0),
              _buildFilterChip('Recipes', 1),
              _buildFilterChip('Following', 2),
            ],
          ),
          const SizedBox(height: 8),
          if (_selectedIndex == 0) _buildTrendingPosts(),
          if (_selectedIndex == 1) _buildRecipes(),
          if (_selectedIndex == 2) _buildFollowing(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateRecipeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    return FilterChip(
      label: Text(label),
      selected: _selectedIndex == index,
      onSelected: (bool selected) {
        setState(() {
          _selectedIndex = index;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.blue[100],
    );
  }

  Widget _buildTrendingPosts() {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        final trendingRecipes = recipeProvider.trendingRecipes;
        
        return Expanded(
          child: ListView.builder(
            itemCount: trendingRecipes.length,
            itemBuilder: (context, index) {
              final recipe = trendingRecipes[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListTile(
                  leading: recipe.imageUrl != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(recipe.imageUrl!),
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.restaurant),
                      ),
                  title: Text(recipe.title),
                  subtitle: Text(
                    recipe.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    // TODO: Navigate to recipe detail screen
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRecipes() {
    return const Center(
      child: Text('Recipes coming soon!'),
    );
  }

  Widget _buildFollowing() {
    return const Center(
      child: Text('Following coming soon!'),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
