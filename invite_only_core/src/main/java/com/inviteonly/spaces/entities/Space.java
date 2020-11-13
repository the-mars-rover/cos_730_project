package com.inviteonly.spaces.entities;

import com.inviteonly.entries.entities.SpaceEntry;
import com.inviteonly.invites.entities.Invite;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.lang.Nullable;

@Entity
@Data
public class Space {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

  @NotNull
  private String title;

  @NotNull
  @ElementCollection
  private Set<String> managerPhones;

  @NotNull
  @ElementCollection
  private Set<String> guardPhones;

  @NotNull
  @ElementCollection
  private Set<String> inviterPhones;

  @Nullable
  private String imageUrl;

  @Nullable
  private BigDecimal locationLatitude;

  @Nullable
  private BigDecimal locationLongitude;

  @OneToMany(mappedBy = "space", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
  private List<SpaceEntry> entries;

  @OneToMany(mappedBy = "space", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
  private List<Invite> invites;

  public boolean hasManager(String phoneNumber) {
    return managerPhones.contains(phoneNumber);
  }

  public boolean hasInviter(String phoneNumber) {
    return inviterPhones.contains(phoneNumber);
  }

  public boolean hasGuard(String phoneNumber) {
    return guardPhones.contains(phoneNumber);
  }

  public boolean hasResident(String phoneNumber) {
    return managerPhones.contains(phoneNumber) || inviterPhones.contains(phoneNumber) || guardPhones
        .contains(phoneNumber);
  }
}
