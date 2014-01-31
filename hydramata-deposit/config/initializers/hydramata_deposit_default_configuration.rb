Hydramata.configure do |hydramata|
  hydramata.layout.theme = 'hydramata/deposit'
  hydramata.deposit do |deposit|
    deposit.work_draft_creator = lambda {|object, attributes|
      Hydramata::Core::WorkDraft.create!(
        pid: object.minted_identifier,
        attributes_store: attributes,
        work_type: object.work_type
      )
    }
    deposit.work_draft_attribute_loader = lambda {|form|
      work_draft = Hydramata::Core::WorkDraft.where(pid: form.minted_identifier).first!
      form.attributes = work_draft.attributes_store
    }

    deposit.new_form_for.generic_work =
    {
      fieldsets: {
        required:
        {
          attributes: {
            title: String,
            contributors_attributes: Array[Hydramata::Contributor],
            description: String
          },
          validates: {
            title: {presence: true},
            description: {presence: true}
          },
        },
        additional:
        {
          attributes: {
            subject: Array[String],
            publisher: Array[String],
            bibliographic_citation: Array[String],
            source: Array[String],
            language: Array[String],
          }
        },
        content:
        {
          attributes: {
            linked_resource_urls: Array[String],
            files: Array[File],
          }
        },
        identifier: {
          attributes: {
            doi_assignment_strategy: String,
            existing_identifier: String,
            embargo_release_date: Date
          }
        },
        access_rights: {
          attributes: {
            visibility: [String, default: 'restricted'],
            rights: [String, default: 'All rights reserved']
          },
          validates: {
            visibility: {presence: true},
            rights: {presence: true}
          }
        }
      },
      on_save: {
        write_attributes: deposit.work_draft_creator
      },
      on_load_from_persistence: {
        load_attributes: deposit.work_draft_attribute_loader
      },
      identity_minter: 'Hydramata::Core::NoidMintingService'
    }

    deposit.new_form_for.article =
    {
      fieldsets: {
        required:
        {
          attributes: {
            title: String,
            contributors_attributes: Array[Hydramata::Contributor],
            abstract: String
          },
          validates: {
            title: {presence: true},
            abstract: {presence: true}
          },
        },
        additional:
        {
          attributes: {
            subject: Array[String],
            publisher: Array[String],
            recommended_citation: Array[String],
            language: Array[String],
          }
        },
        content:
        {
          attributes: {
            linked_resource_urls: Array[String],
            files: Array[File],
          }
        },
        identifier: {
          attributes: {
            doi_assignment_strategy: String,
            existing_identifier: String,
            embargo_release_date: Date
          }
        },
        access_rights: {
          attributes: {
            visibility: [String, default: 'restricted'],
            rights: [String, default: 'All rights reserved']
          },
          validates: {
            visibility: {presence: true},
            rights: {presence: true}
          }
        }
      },
      on_save: {
        write_attributes: deposit.work_draft_creator
      },
      on_load_from_persistence: {
        load_attributes: deposit.work_draft_attribute_loader
      },
      identity_minter: 'Hydramata::Core::NoidMintingService'
    }

    deposit.new_form_for.dataset =
    {
      fieldsets: {
        required:
        {
          attributes: {
            title: String,
            contributors_attributes: Array[Hydramata::Contributor],
            description: String
          },
          validates: {
            title: {presence: true},
            description: {presence: true}
          },
        },
        additional:
        {
          attributes: {
            subject: Array[String],
            publisher: Array[String],
            recommended_citation: Array[String],
            language: Array[String],
          }
        },
        content:
        {
          attributes: {
            linked_resource_urls: Array[String],
            files: Array[File],
          }
        },
        identifier: {
          attributes: {
            doi_assignment_strategy: String,
            existing_identifier: String,
            embargo_release_date: Date
          }
        },
        access_rights: {
          attributes: {
            visibility: [String, default: 'restricted'],
            rights: [String, default: 'All rights reserved']
          },
          validates: {
            visibility: {presence: true},
            rights: {presence: true}
          }
        }
      },
      on_save: {
        write_attributes: deposit.work_draft_creator
      },
      on_load_from_persistence: {
        load_attributes: deposit.work_draft_attribute_loader
      },
      identity_minter: 'Hydramata::Core::NoidMintingService'
    }

    deposit.new_form_for.image =
    {
      fieldsets: {
        required:
        {
          attributes: {
            title: String,
            contributors_attributes: Array[Hydramata::Contributor],
            date_created: Array[Date],
            description: String,
            category: Array[String],
            location: Array[String],
            measurements: Array[String],
            material: Array[String]
          },
          validates: {
            title: {presence: true},
            description: {presence: true}
          },
        },
        additional:
        {
          attributes: {
            source: Array[String],
            publisher: Array[String],
            subject: Array[String],
            inscription: Array[String],
            StateEdition: Array[String],
            textref: Array[String],
            cultural_context: Array[String],
            style_period: Array[String],
            technique: Array[String],
          },
        },
        content:
        {
          attributes: {
            files: Array[File],
          }
        },
        identifier: {
          attributes: {
            doi_assignment_strategy: String,
            existing_identifier: String,
            embargo_release_date: Date
          }
        },
        access_rights: {
          attributes: {
            visibility: [String, default: 'restricted'],
            rights: [String, default: 'All rights reserved']
          },
          validates: {
            visibility: {presence: true},
            rights: {presence: true}
          }
        }
      },
      on_save: {
        write_attributes: deposit.work_draft_creator
      },
      on_load_from_persistence: {
        load_attributes: deposit.work_draft_attribute_loader
      },
      identity_minter: 'Hydramata::Core::NoidMintingService'
    }

    deposit.new_form_for.document =
    {
      fieldsets: {
        required:
        {
          attributes: {
            title: String,
            contributors_attributes: Array[Hydramata::Contributor],
            description: String
          },
          validates: {
            title: {presence: true},
            description: {presence: true}
          },
        },
        additional:
        {
          attributes: {
            type: String,
            subject: Array[String],
            publisher: Array[String],
            bibliographic_citation: Array[String],
            source: Array[String],
            language: Array[String],
          },
          validates: {
            type: {inclusion: { in: [
                                  'Book',
                                  'Book Chapter',
                                  'Document',
                                  'Report',
                                  'Pamphlet',
                                  'Brochure',
                                  'Manuscript',
                                  'Letter',
                                  'Newsletter',
                                  'Press Release',
                                  'White Paper'
            ], allow_blank: true }}
          }
        },
        content:
        {
          attributes: {
            linked_resource_urls: Array[String],
            files: Array[File],
          }
        },
        identifier: {
          attributes: {
            doi_assignment_strategy: String,
            existing_identifier: String,
            embargo_release_date: Date
          }
        },
        access_rights: {
          attributes: {
            visibility: [String, default: 'restricted'],
            rights: [String, default: 'All rights reserved']
          },
          validates: {
            visibility: {presence: true},
            rights: {presence: true}
          }
        }
      },
      on_save: {
        write_attributes: deposit.work_draft_creator
      },
      on_load_from_persistence: {
        load_attributes: deposit.work_draft_attribute_loader
      },
      identity_minter: 'Hydramata::Core::NoidMintingService'
    }

  end

end
