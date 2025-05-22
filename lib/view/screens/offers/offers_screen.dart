import 'package:binrushd_medical_center/controller/fetch_offers_provider.dart';
import 'package:binrushd_medical_center/view/screens/offers/offer_details_screen.dart';
import 'package:binrushd_medical_center/view/widgets/offer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final offerProvider =
          Provider.of<FetchOffersProvider>(context, listen: false);
      offerProvider.fetchOffers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("العروض",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ),
        body: Consumer<FetchOffersProvider>(
          builder: (context, provider, child) {
            if (provider.offersResponse == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final campaigns = provider.offersResponse!.data.campaigns;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap:
                        true, // This ensures the ListView only takes up the space it needs
                    scrollDirection: Axis.vertical,
                    itemCount: campaigns.length,
                    itemBuilder: (context, index) {
                      final campaign = campaigns[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OfferDetailsScreen(
                                title: campaign.title,
                                description: campaign.description,
                                endTime: campaign.endTime,
                              ),
                            ),
                          );
                        },
                        child: OfferCard(
                          title: campaign.title,
                          imageUrl: campaign.image,
                        ),
                      );
                    },
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
