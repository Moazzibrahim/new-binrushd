import 'package:binrushd_medical_center/controller/Auth/login_provider.dart';
import 'package:binrushd_medical_center/view/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/controller/fetch_posts_provider.dart';
import 'package:provider/provider.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({super.key});

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch posts when the screen loads
    Provider.of<FetchPostsProvider>(context, listen: false).fetchPosts(context);
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<FetchPostsProvider>(context);
    final loginprovider = Provider.of<LoginProvider>(context, listen: false);
    String? token = loginprovider.token;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'مقالات صحية',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              token == null
                  ? Navigator.pop(context)
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TabsScreen()));
            },
          ),
        ],
      ),
      body: postsProvider.postResponse == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : postsProvider.postResponse!.data.isEmpty
              ? const Center(
                  child: Text(
                    'لا توجد مقالات حالياً.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: postsProvider.postResponse!.data.length,
                    itemBuilder: (context, index) {
                      final article = postsProvider.postResponse!.data[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Article image
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(article.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Article title
                            Text(
                              article.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Article content
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                article.content,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
