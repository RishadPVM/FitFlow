import 'package:flutter/material.dart';
import 'package:fitflow/core/theme/app_colors.dart';
import 'shared_components.dart';

Widget buildAdminInviteSection() {
  return buildProfileSection(
    title: 'Invite / Referral System',
    children: [
      buildProfileListTile(
        icon: Icons.share_rounded,
        title: 'Share Invite Link',
        subtitle: 'fitflow.com/invite/titan-elite',
        trailing: const Icon(Icons.copy_rounded, color: AppColors.primaryBlue, size: 20),
        onTap: () {}, // copy to clipboard
      ),
      const Divider(height: 1),
      buildProfileListTile(
        icon: Icons.qr_code_2_rounded,
        title: 'Show QR Code',
        subtitle: 'Display gym QR code to walk-ins',
        onTap: () {}, 
      ),
      const Divider(height: 1),
      buildProfileListTile(
        icon: Icons.people_alt_rounded,
        title: 'Track Invites',
        subtitle: '14 successful referrals',
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        onTap: () {}, 
      ),
    ],
  );
}
