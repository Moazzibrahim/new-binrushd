import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/branches/fetch_branches_provider.dart';
import 'package:binrushd_medical_center/view/screens/branches/branch_details_screen.dart';
import 'package:provider/provider.dart';

class AllBranchesScreen extends StatefulWidget {
  const AllBranchesScreen({super.key});

  @override
  State<AllBranchesScreen> createState() => _AllBranchesScreenState();
}

class _AllBranchesScreenState extends State<AllBranchesScreen> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final fetchProvider =
          Provider.of<FetchBranchesProvider>(context, listen: false);
      fetchProvider.loadCachedBranches();
      fetchProvider.fetchBranches(context);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the branches data using the provider
    final fetchBranchesProvider = Provider.of<FetchBranchesProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('الفروع',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display branches fetched from the provider
              fetchBranchesProvider.branchResponse == null
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loading if data is null
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          fetchBranchesProvider.branchResponse!.data.length,
                      itemBuilder: (context, index) {
                        final branch =
                            fetchBranchesProvider.branchResponse!.data[index];
                        return CenterCard(
                          location: branch.address,
                          imageUrl: branch.image,
                          id: branch.id,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CenterCard extends StatelessWidget {
  final String location;
  final String imageUrl;
  final int? id;

  const CenterCard({
    super.key,
    required this.location,
    required this.imageUrl,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 70,
                height: 83,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BranchDetailsScreen(
                                    branchId: id,
                                    image: imageUrl,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Circular shape for the button
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10)),
                    child: const Text(
                      'تفاصيل',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 6,
            ),
          ],
        ),
      ),
    );
  }
}
